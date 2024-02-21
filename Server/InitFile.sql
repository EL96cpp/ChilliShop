CREATE DATABASE chilli_shop;
\c chilli_shop;
CREATE TABLE active_orders (order_id SERIAL, phone_number CHAR(11), ordered_timestamp TIMESTAMP WITHOUT TIME ZONE, receive_code CHAR(4), total_cost INT, order_data TEXT, is_ready BOOL);
CREATE TABLE received_orders (order_id SERIAL, phone_number CHAR(11), ordered_timestamp TIMESTAMP WITHOUT TIME ZONE, received_timestamp TIMESTAMP WITHOUT TIME ZONE, receive_code CHAR(4), total_cost INT, order_data TEXT);
CREATE TABLE catalog (product_id INT, product_type TEXT, product_name TEXT, price INT, scoville INT, description TEXT);
CREATE TABLE employees (name TEXT, surname TEXT, position TEXT, password TEXT);
CREATE TABLE customers (phone_number CHAR(11), password TEXT, name TEXT);
\copy catalog FROM 'Catalog/catalog.csv' DELIMITER '/';
\copy employees FROM 'Catalog/employee.csv' DELIMITER '/';

