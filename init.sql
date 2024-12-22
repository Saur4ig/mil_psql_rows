-- Enable the uuid-ossp extension for UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


-- ------------------------------------------------
-- Table: customers
-- ------------------------------------------------
CREATE TABLE customers
(
    customer_id UUID PRIMARY KEY      DEFAULT uuid_generate_v4(),
    first_name  VARCHAR(100) NOT NULL,
    last_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(255) NOT NULL UNIQUE,
    phone       VARCHAR(50),
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------
-- Table: orders
-- ------------------------------------------------
CREATE TABLE orders
(
    order_id         UUID PRIMARY KEY        DEFAULT uuid_generate_v4(),
    customer_id      UUID           NOT NULL,
    order_date       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status           VARCHAR(50)    NOT NULL DEFAULT 'PENDING',
    total_amount     NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    shipping_address VARCHAR(255),
    created_at       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
            REFERENCES customers (customer_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

-- ------------------------------------------------
-- Table: products
-- ------------------------------------------------
CREATE TABLE products
(
    product_id   UUID PRIMARY KEY        DEFAULT uuid_generate_v4(),
    product_name VARCHAR(150)   NOT NULL,
    description  TEXT,
    price        NUMERIC(10, 2) NOT NULL,
    stock_qty    INT            NOT NULL DEFAULT 0,
    created_at   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------
-- Table: order_items
-- ------------------------------------------------
CREATE TABLE order_items
(
    order_item_id UUID PRIMARY KEY        DEFAULT uuid_generate_v4(),
    order_id      UUID           NOT NULL,
    product_id    UUID           NOT NULL,
    quantity      INT            NOT NULL DEFAULT 1,
    item_price    NUMERIC(10, 2) NOT NULL,
    created_at    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
            REFERENCES orders (order_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,

    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
            REFERENCES products (product_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);
