# E-Commerce Database System

This repository contains the implementation of a comprehensive e-commerce database system, including a backend SQL database and a frontend GUI application written in Python using Tkinter. The project demonstrates proficiency in SQL schema design, complex queries, data integrity, and creating a user-friendly interface to interact with the database.

## Project Structure

- `ecommerce_db_setup.sql` - This file contains all SQL scripts for creating and setting up the database schema, including tables for users, products, orders, etc., as well as additional features like views, triggers, and stored procedures.
- `ecommerce_gui.py` - This Python script provides a basic graphical user interface to interact with the database, allowing users to view products and place orders.

## Database Schema

The database includes the following main tables:
- **Users**: Stores user details.
- **Categories**: Stores product categories.
- **Products**: Stores products details, linked to categories.
- **Orders**: Stores orders made by users.
- **Order Details**: Stores details of products ordered.
- **Payments**: Stores payment details for orders.
- **Reviews**: Stores reviews submitted by users for products.

Additional components include:
- **Views** (ProductCatalog, CustomerOrders) to simplify data access.
- **Triggers** for maintaining data integrity and automating tasks like stock updates.
- **Stored Procedures** for common operations like placing orders and processing payments.
- **Functions** to calculate total sales for a product.

## Setup Instructions

### Database Setup

1. Ensure MySQL is installed on your system.
2. Run the `ecommerce_db_setup.sql` script in your MySQL environment to set up the database and all required tables and procedures.

### Python GUI Setup

1. Ensure Python is installed on your system.
2. Install required packages:
   ```bash
   pip install mysql-connector-python
Run ecommerce_gui.py to start the application:
bash
Copy code
python ecommerce_gui.py

Using the GUI
Load Products: Click on the 'Load Products' button to fetch and display products from the database.

Place Order: Currently, the 'Place Order' button is set up as an example. You can customize it to place actual orders by modifying the place_order function call within the GUI code.

Contributions:
Contributions are welcome! Please fork the repository and submit pull requests with your proposed changes.
