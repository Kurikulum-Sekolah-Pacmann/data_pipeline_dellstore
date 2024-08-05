# Source to Target Mapping

Source: Staging
Target: Warehouse


- Source Table: orders
- Target Table: orders

| Source Field | Target Field  | Transformation Rule                                                                 |
|--------------|---------------|-------------------------------------------------------------------------------------|
| -            | order_id      | Auto Generated using `uuid_generate_v4()`                                           |
| orderid     | order_nk      | Direct Mapping                                                                      |
| customerid  | customer_id   | Use the customer_id from the customer table by matching the customer_nk (source)    |
| orderdate   | order_date    | Direct Mapping                                                                      |
| status       | status        | Direct Mapping                                                                      |
| netammount   | net_ammount    | Direct Mapping                                                                      |
| tax       | tax        | Direct Mapping                                                                      |
| totalammount   | total_ammount    | Direct Mapping                                                                      |

- Source Table: categories
- Target Table: categories

| Source Field | Target Field  | Transformation Rule                                  |
|--------------|---------------|------------------------------------------------------|
| category     | category_nk   | Direct Mapping                                       |
| -            | category_id   | Auto Generated using `uuid_generate_v4()`            |
| categoryname | category_name | Direct Mapping                                       |


- Source Table: customers
- Target Table: customers

| Source Field         | Target Field           | Transformation Rule                                                  |
|----------------------|------------------------|----------------------------------------------------------------------|
| customerid           | customer_nk            | Direct Mapping                                                       |
| -                    | customer_id            | Auto Generated using `uuid_generate_v4()`                            |
| firstname            | first_name             | Direct Mapping                                                       |
| lastname             | last_name              | Direct Mapping                                                       |
| address1             | address1               | Direct Mapping                                                       |
| address2             | address2               | Direct Mapping                                                       |
| city                 | city                   | Direct Mapping                                                       |
| state                | state                  | Direct Mapping                                                       |
| zip                  | zip                    | Direct Mapping                                                       |
| country              | country                | Direct Mapping                                                       |
| region               | region                 | Direct Mapping                                                       |
| email                | email                  | Direct Mapping                                                       |
| phone                | phone                  | Direct Mapping                                                       |
| creditcardtype       | credit_card_type       | Direct Mapping                                                       |
| creditcard           | credit_card            | Direct Mapping  and Masking Value                                    |
| creditcardexpiration | credit_card_expiration | Direct Mapping                                                       |
| username             | username               | Direct Mapping                                                       |
| password             | password               | Direct Mapping                                                       |
| age                  | age                    | Direct Mapping                                                       |
| income               | income                 | Direct Mapping                                                       |
| gender               | gender                 | Direct Mapping                                                       |

- Source Table: inventory
- Target Table: inventory

| Source Field  | Target Field     | Transformation Rule                                  |
|---------------|------------------|------------------------------------------------------|
| prod_id       | product_nk       | Direct Mapping                                       |
| -             | product_id       | Use the product_id from the product table by matching the product_nk (source)          |
| quan_in_stock | quantity_stock   | Direct Mapping                                       |
| sales         | sales            | Direct Mapping                                       |

- Source Table: order_status_analytic
- Target Table: order_status_analytic

| Source Field | Target Field     | Transformation Rule                                  |
|--------------|------------------|------------------------------------------------------|
| orderid      | order_nk         | Direct Mapping                                       |
| -            | order_id         | Auto Generated using `uuid_generate_v4()`            |
| sum_stock    | sum_stock        | Direct Mapping                                       |
| status       | status           | Direct Mapping                                       |

- Source Table: cust_hist
- Target Table: cust_hist

| Source Field | Target Field   | Transformation Rule                                                                 |
|--------------|----------------|-------------------------------------------------------------------------------------|
| customerid   | customer_id    | Lookup `customer_id` from `customers` table based on `customerid`                   |
| orderid      | order_id       | Lookup `order_id` from `orders` table based on `orderid`                             |
| prod_id      | product_id     | Lookup `product_id` from `products` table based on `prod_id`                         |
| created_at   | created_at     | Direct Mapping                                                                      |

- Source Table: products
- Target Table: products

| Source Field  | Target Field     | Transformation Rule                                                                 |
|---------------|------------------|-------------------------------------------------------------------------------------|
| prod_id       | product_nk       | Direct Mapping                                                                      |
| -             | product_id       | Auto Generated using `uuid_generate_v4()`                                           |
| category      | category_id      | Lookup `category_id` from `categories` table based on `category`                    |
| title         | title            | Direct Mapping                                                                      |
| actor         | actor            | Direct Mapping                                                                      |
| price         | price            | Direct Mapping                                                                      |
| special       | special          | Direct Mapping                                                                      |
| common_prod_id| common_prod_id   | Direct Mapping                                                                      |

- Source Table: orderlines
- Target Table: orderlines

| Source Field  | Target Field  | Transformation Rule                                                                     |
|---------------|---------------|-----------------------------------------------------------------------------------------|
| orderlineid  | orderline_nk  | Direct Mapping                                                                          |
| -             | orderline_id  | Auto Generated using `uuid_generate_v4()`                                               |
| orderid       | order_id      | Lookup `order_id` from `orders` table based on `orderid`                                |
| prod_id       | product_id    | Lookup `product_id` from `products` table based on `prod_id`                            |
| quantity      | quantity      | Direct Mapping                                                                          |
| orderdate     | order_date    | Direct Mapping                                                                          |


- Source Table: customer_orders_history
- Target Table: customers

| Source Field              | Target Field          | Transformation Rule                                                                  |
|---------------------------|-----------------------|--------------------------------------------------------------------------------------|
| customer_id               | customer_nk           | Direct Mapping                                                                       |
| -                         | customer_id           | Auto Generated using `uuid_generate_v4()`                                            |
| customer_firstname        | first_name            | Direct Mapping                                                                       |
| customer_lastname         | last_name             | Direct Mapping                                                                       |
| customer_address1         | address1              | Direct Mapping                                                                       |
| customer_address2         | address2              | Direct Mapping                                                                       |
| customer_city             | city                  | Direct Mapping                                                                       |
| customer_state            | state                 | Direct Mapping                                                                       |
| customer_zip              | zip                   | Direct Mapping                                                                       |
| customer_country          | country               | Direct Mapping                                                                       |
| customer_region           | region                | Direct Mapping                                                                       |
| customer_email            | email                 | Direct Mapping                                                                       |
| customer_phone            | phone                 | Direct Mapping                                                                       |
| customer_creditcardtype   | credit_card_type      | Direct Mapping and Masking                                                                       |
| customer_creditcard       | credit_card           | Direct Mapping                                                                       |
| customer_creditcardexpiration | credit_card_expiration | Direct Mapping                                                                   |
| customer_username         | username              | Direct Mapping                                                                       |
| customer_password         | password              | Direct Mapping                                                                       |
| customer_age              | age                   | Direct Mapping                                                                       |
| customer_income           | income                | Direct Mapping                                                                       |
| customer_gender           | gender                | Direct Mapping                                                                       |

- Source Table: customer_orders_history
- Target Table: products

| Source Field              | Target Field          | Transformation Rule                                                                  |
|---------------------------|-----------------------|--------------------------------------------------------------------------------------|
| product_id                | product_nk            | Direct Mapping                                                                       |
| -                         | product_id            | Auto Generated using `uuid_generate_v4()`                                            |
| product_category          | category_id           | Lookup `category_id` from `categories` table based on `product_category`             |
| product_title             | title                 | Direct Mapping                                                                       |
| product_actor             | actor                 | Direct Mapping                                                                       |
| product_price             | price                 | Direct Mapping                                                                       |
| product_special           | special               | Direct Mapping                                                                       |
| product_common_prod_id    | common_prod_id        | Direct Mapping                                                                       |

- Source Table: customer_orders_history
- Target Table: orders

| Source Field              | Target Field          | Transformation Rule                                                                  |
|---------------------------|-----------------------|--------------------------------------------------------------------------------------|
| order_id                  | order_nk              | Direct Mapping                                                                       |
| -                         | order_id              | Auto Generated using `uuid_generate_v4()`                                            |
| order_customerid          | customer_id           | Lookup `customer_id` from `customers` table based on `order_customerid`              |
| order_date                | order_date            | Direct Mapping                                                                       |
| order_netamount           | net_amount            | Direct Mapping                                                                       |
| order_tax                 | tax                   | Direct Mapping                                                                       |
| order_totalamount         | total_amount          | Direct Mapping                                                                       |

- Source Table: customer_orders_history
- Target Table: orderlines

| Source Field              | Target Field          | Transformation Rule                                                                  |
|---------------------------|-----------------------|--------------------------------------------------------------------------------------|
| orderline_id              | orderline_nk          | Direct Mapping                                                                       |
| -                         | orderline_id          | Auto Generated using `uuid_generate_v4()`                                            |
| order_id                  | order_id              | Lookup `order_id` from `orders` table based on `order_id`                            |
| product_id                | product_id            | Lookup `product_id` from `products` table based on `product_id`                      |
| orderline_quantity        | quantity              | Direct Mapping                                                                       |
| orderline_orderdate       | order_date            | Direct Mapping                                                                       |

