# E-Commerce Database System

## Introduction
This repository houses an advanced e-commerce database system, featuring a backend SQL database integrated with a frontend GUI application developed in Python using Tkinter. The system is meticulously crafted to demonstrate robust SQL schema design, complex queries, data integrity enforcement, and building a user-friendly interface for interactive database operations. It serves as an ideal educational tool for students, developers, and database administrators interested in learning about real-world database application integrations.

## Project Objective
The primary objective of this project is to provide a practical example of how to structure and implement a fully functional e-commerce database system. This includes the setup of a comprehensive SQL database and the development of a Python-based GUI that acts as an interface for viewing and managing the product catalog and customer orders.

## Project Structure
- **`ecommerce_db_setup.sql`**: Includes all SQL scripts for the initial database setup — creating tables for users, products, orders, and additional features such as views, triggers, and stored procedures for advanced database operations.
- **`ecommerce_gui.py`**: This Python script provides the graphical user interface, facilitating direct interactions with the database. It allows for operations such as viewing product details and placing orders.

## Database Schema Overview
The schema is designed to support an e-commerce platform with the following tables and components:
- **Tables**:
  - **Users**: Contains user authentication and profile details.
  - **Categories**: Lists product categories.
  - **Products**: Details about products including names, categories, and pricing.
  - **Orders**: Order transactions recorded by users.
  - **Order Details**: Specific details of items within each order.
  - **Payments**: Financial transactions related to orders.
  - **Reviews**: User-generated product reviews.

- **Additional Components**:
  - **Views**: `ProductCatalog` and `CustomerOrders` simplify the SQL queries for common data retrieval tasks.
  - **Triggers**: Automate tasks such as updating stock levels upon order placement and maintaining audit logs.
  - **Stored Procedures**: Encapsulate business logic for transactions like order processing and payment handling.
  - **Functions**: Assist in calculating aggregated data such as total sales per product.

## Detailed Setup Instructions

### Database Setup
1. **MySQL Installation**: Download and install MySQL Server from the official site. Ensure it is configured correctly on your local machine or server.
2. **Schema Creation**: Navigate to the MySQL command interface and run the `ecommerce_db_setup.sql` script to establish your database and populate it with initial data.

### Python GUI Setup
1. **Python Installation**: Ensure Python 3.x is installed. Visit Python's official website for installation guides.
2. **Dependency Installation**:
   ```bash
   pip install mysql-connector-python tkinter
   ```
3. **Running the Application**:
   Execute the script to launch the GUI:
   ```bash
   python ecommerce_gui.py
   ```

## Python GUI Application Details

### Functional Components

#### `create_db_connection`
- Establishes a connection to the database using mysql-connector. It handles potential exceptions by displaying a GUI error message if the connection cannot be established.

#### `load_products`
- Fetches and displays products from the `ProductCatalog` view in the database. This method populates a Treeview widget in the GUI, allowing users to see product details like ID, name, price, and stock levels.

#### `place_order`
- Simulates the process of placing an order for a product. It uses stored procedures to insert a new order into the database and commits these changes if successful. Errors during the transaction are handled gracefully with informative messages.

### GUI Description
- **Interface**: The GUI is designed for ease of use with clear labels and buttons for interaction.
- **Navigation**: Users can navigate through product listings and select items they wish to order.

## Future Enhancements
- **Feature Expansion**: Plans to include user registration and login functionalities.
- **Performance Optimization**: Enhance query performance and GUI responsiveness.
- **Security Improvements**: Implement advanced security measures for data protection and secure transactions.

## Contributions
We highly value community contributions. If you are interested in enhancing the functionalities or improving the design, please fork this repository, make your changes in a dedicated branch, and submit a pull request for review.

## License
Distributed under the MIT License. See `LICENSE` for more information.

## Contact
For any questions or to report issues, please open an issue in this repository and we will address it as promptly as possible.

