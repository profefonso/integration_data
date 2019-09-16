import mysql.connector
from mysql.connector import Error

connection = mysql.connector.connect(host='localhost', database='ODS', user='root', password='secret')
try:
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("Your connected to database: ", record)

        query_dic = {
            "customer_calls": "DELETE FROM customer_calls",
            "payments": "DELETE FROM payments",
            "orderdetails": "DELETE FROM orderdetails",
            "customers_products": "DELETE FROM customers_products",
            "orders": "DELETE FROM orders",
            "employees": "DELETE FROM employees",
            "products": "DELETE FROM products",
            "productlines": "DELETE FROM productlines",
            "offices": "DELETE FROM offices",
            "customers": "DELETE FROM customers",
        }

        for table, query in query_dic.items():
            print("Delete Table:: ", table)
            cursor.execute(query)

        connection.commit()
except Error as e:
    print("Error while delete ODS to MySQL", e)
finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")
