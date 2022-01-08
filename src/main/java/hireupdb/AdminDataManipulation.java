
/* 
 * This file is used for doing data manipulation such as,
 * Insert, Update, Delete query on Admin Database table of hireupv1 database
 * */

package hireupdb;

import java.sql.*;
import java.util.*;

public class AdminDataManipulation {

	public static void main(String[] args) {
	
		try {
			Scanner scan = new Scanner(System.in);
			
			Connection con = DbConnection.getConnection();
			
			System.out.print("Enter Username: ");
			String adminUsername = scan.nextLine();
			
			System.out.print("Enter Password: ");
			String adminPassword = scan.nextLine();
			
			/* Performing insert operation on hireupv1.Admin table */
			String insertQuery = "INSERT INTO admin VALUES (?, ?)";
			
			PreparedStatement pst = con.prepareStatement(insertQuery);
			pst.setString(1, adminUsername);
			pst.setString(2, adminPassword);
			
			int status = pst.executeUpdate();
			
			if(status != 0)
			{
				System.out.print("\n Data Inserted into hireupv1.admin table");
			}
			
			if(status == 0)
			{
				System.out.print("\n Data Insertion Error! Try Again");
			}
			
			con.close();
			scan.close();
		
		} /* try block close */
		catch(Exception e)
		{
			System.out.print("AdminDataManipulation.java Exception: " + e);
		} /* catch block close */
	
	} /* main() close */

} /* public class AdminDataManipulation.java close */
