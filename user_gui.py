import tkinter as tk
from tkinter import messagebox
import mysql.connector

# Connect to MySQL database
db = mysql.connector.connect(
    host="your_host",
    user="your_username",
    password="your_password",
    database="your_database"
)

# Create cursor
cursor = db.cursor()

# Function to add a new user
def add_user(username, email, password):
    try:
        sql = "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)"
        val = (username, email, password)
        cursor.execute(sql, val)
        db.commit()
        messagebox.showinfo("Success", "User added successfully")
    except mysql.connector.Error as err:
        messagebox.showerror("Error", f"Error: {err}")

# Function to authenticate user
def authenticate_user(username, password):
    try:
        sql = "SELECT * FROM users WHERE username = %s AND password = %s"
        val = (username, password)
        cursor.execute(sql, val)
        user = cursor.fetchone()
        if user:
            messagebox.showinfo("Success", "Login successful")
            display_user_info(user)
        else:
            messagebox.showerror("Error", "Invalid username or password")
    except mysql.connector.Error as err:
        messagebox.showerror("Error", f"Error: {err}")

# Function to display user information
def display_user_info(user):
    messagebox.showinfo("User Info", f"Username: {user[1]}\nEmail: {user[2]}\nCreated At: {user[4]}")

# Function to handle registration button click
def register():
    username = username_entry.get()
    email = email_entry.get()
    password = password_entry.get()
    add_user(username, email, password)

# Function to handle login button click
def login():
    username = username_entry.get()
    password = password_entry.get()
    authenticate_user(username, password)

# GUI setup
root = tk.Tk()
root.title("User Authentication")

# Username Label and Entry
username_label = tk.Label(root, text="Username:")
username_label.grid(row=0, column=0, padx=10, pady=5)
username_entry = tk.Entry(root)
username_entry.grid(row=0, column=1, padx=10, pady=5)

# Email Label and Entry
email_label = tk.Label(root, text="Email:")
email_label.grid(row=1, column=0, padx=10, pady=5)
email_entry = tk.Entry(root)
email_entry.grid(row=1, column=1, padx=10, pady=5)

# Password Label and Entry
password_label = tk.Label(root, text="Password:")
password_label.grid(row=2, column=0, padx=10, pady=5)
password_entry = tk.Entry(root, show="*")
password_entry.grid(row=2, column=1, padx=10, pady=5)

# Register Button
register_button = tk.Button(root, text="Register", command=register)
register_button.grid(row=3, column=0, padx=5, pady=10)

# Login Button
login_button = tk.Button(root, text="Login", command=login)
login_button.grid(row=3, column=1, padx=5, pady=10)

# Run the GUI
root.mainloop()
