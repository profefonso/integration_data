import mysql.connector
from mysql.connector import Error

PATH_TO_FILE = '../sql_scripts/CRATE_BASIC_SCHEMA_DATA_INTEGRATION.sql'
connection = mysql.connector.connect(host='localhost', database='data_integration', user='root', password='secret')
try:
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        cursor = connection.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("Your connected to database: ", record)

        for line in open(PATH_TO_FILE):
            if '--' in line:
                print(line)
            else:
                cursor.execute(line)

        connection.commit()
except Error as e:
    print("Error while Basic schema to MySQL", e)
finally:
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")
