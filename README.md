# ChilliShop
ChilliShop is a system for delivery of chilli sauces, seeds and seasonings. It includes async Server, Customer and Employee applications.
## Customer 
Customer application

## Database 
Server application uses PostgreSQL database. Database 'chilli_shop' includes five tables: active_orders, received_orders, catalog, employees and customers.<br /> To setup database, corresponding tables and fill them with data run next line in terminal: ```  psql -U user_name < InitFile.sql ```
