package hireupdb;

import java.sql.*;

public class DbConnection {

	public static final String url = "jdbc:mysql://localhost:3306/";  //URL
	public static final String database = "hireupv1";				  // MYSQL Database Name
	public static final String user = "root";						  // Mysql User name
	public static final String pass = "root"; 						  // Mysql password
	
	/*
	 * This is static of DbConnection class
	 * DbConnection class belong to hireupdb package
	 * 
	 * This method return connection object
	 * connection object is accessed for database connectivity whenever required
	 * By including the hireupdb package And,
	 * Calling getConnection() method which return connection object
	 */
	public static Connection getConnection()
	{
		Connection con = null;
		try {
			
			/*
			 * Class.forName() is used to define the driver used The driver specify which Database we are using, 
			 * In this case we are using Mysql database 
			 * The MysqlConnectorJ jar file is placed in src/main/webapp/WEB-INF/lib folder
			 */
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url + database, user, pass);
		}
		catch(Exception e)
		{
			System.out.println("DbConnection Exception: " + e);
		}
		return con;
	}
}
