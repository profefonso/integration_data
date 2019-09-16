import mysql.connector
from mysql.connector import Error

connection = mysql.connector.connect(host='localhost', database='DWH', user='root', password='secret')
try:
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("Your connected to database: ", record)

        query_dic = {
            "FACT_Sales": "DELETE FROM FACT_Sales",
            "DIM_customers": "DELETE FROM DIM_customers",
            "DIM_products": "DELETE FROM DIM_Products"
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
