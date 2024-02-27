# ChilliShop
ChilliShop is a system for delivery of chilli sauces, seeds and seasonings. It includes async Server, Customer and Employee applications.

## <ins>Server</ins>
Server application works with customer and employee connections. For every new message it creates object (MessageResponder), that runs in separate thread and responds to message. Maximum thread count is set to 10.
### Database 
Server application uses PostgreSQL database. Database 'chilli_shop' includes five tables: active_orders, received_orders, catalog, employees and customers.<br /> To setup database, corresponding tables and fill them with data, run next line in terminal: <br />```  psql -U user_name < InitFile.sql ```
<br />

## <ins>Customer</ins> 
Customer application provides user the ability to view different groups of products, make orders and check their status or cancel them, if needed. 
### Order issuing
To receive his/her order, customer receives four-digit code, and informs employee about his/her phone number and this code. In the delivery tab customer can check, if order is already prepeared and can be issued.
### Customer UI example 
![chilli_shop_ui_example](https://github.com/EL96cpp/ChilliShop/assets/120955824/47e49674-f2f8-40aa-b579-350b48b2c869)

## <ins>Employee</ins>
To work with application employee need to be logged in (enter his or her name, surname, position and password). New employees added in database by management. 
### Orders
In application's workspace employee can either prepare orders or issue them. To avoid conflicts between employees, server stores IDs of each order, which is currently processing or issuing.  
