import tkinter as tk
from tkinter import ttk, messagebox
import mysql.connector

def create_db_connection():
    try:
        connection = mysql.connector.connect(
            host='localhost',  # Or your host
            user='your_username',  # Your database username
            password='your_password',  # Your database password
            database='ecommerce_db'  # Your database name
        )
        return connection
    except mysql.connector.Error as e:
        messagebox.showerror("Database Connection Error", str(e))
        return None

def load_products():
    conn = create_db_connection()
    if conn is not None:
        cursor = conn.cursor()
        cursor.execute("SELECT product_id, name, price, stock FROM ProductCatalog")
        records = cursor.fetchall()
        for row in records:
            product_list.insert("", "end", values=row)
        conn.close()

def place_order(product_id, quantity):
    conn = create_db_connection()
    if conn is not None:
        cursor = conn.cursor()
        try:
            cursor.execute("CALL AddNewOrder(%s, 'Placed')", (user_id,))
            order_id = cursor.lastrowid
            cursor.execute("INSERT INTO order_details (order_id, product_id, quantity, price) SELECT %s, product_id, %s, price FROM products WHERE product_id = %s", (order_id, quantity, product_id))
            conn.commit()
            messagebox.showinfo("Success", "Order placed successfully!")
        except mysql.connector.Error as e:
            messagebox.showerror("Order Error", str(e))
        finally:
            conn.close()

def main():
    global product_list
    root = tk.Tk()
    root.title("E-Commerce System")

    ttk.Label(root, text="Product Catalog", font=('Helvetica', 16)).grid(row=0, column=0, padx=10, pady=10)
    product_list = ttk.Treeview(root, columns=("ID", "Name", "Price", "Stock"), show="headings")
    product_list.grid(row=1, column=0, padx=10, pady=10)
    product_list.heading("ID", text="ID")
    product_list.heading("Name", text="Name")
    product_list.heading("Price", text="Price")
    product_list.heading("Stock", text="Stock")

    ttk.Button(root, text="Load Products", command=load_products).grid(row=2, column=0, padx=10, pady=10)
    ttk.Button(root, text="Place Order", command=lambda: place_order(1, 2)).grid(row=3, column=0, padx=10, pady=10)  # Example button for placing an order

    root.mainloop()

if __name__ == "__main__":
    main()
