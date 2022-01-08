package hireupdb;

import java.sql.*;

public class CreateTables {

	public static void main(String[] args) {

		//DbConnection is public class declared in DbConnection.java in hireupdb package
		Connection con = DbConnection.getConnection();
		
	//Create Admin Table in hireupv1 database
		try
		{	
			String adminTable = "CREATE TABLE Admin"
								+ "("
								+ "Username VARCHAR(50) PRIMARY KEY,"
								+ "Password VARCHAR(20) NOT NULL"
								+ "); ";

			Statement st = con.createStatement();
			st.executeUpdate(adminTable);
				System.out.println("Table 'Admin' Created");
		}
		catch(Exception e)
		{
			System.out.println("CreateTables Admin Exception: " + e);
		}
		
		
	//Create Login Table in hireupv1 database
		try
		{	
			String loginTable = "CREATE TABLE Login "
								+ "("
								+ "Email VARCHAR(320) PRIMARY KEY,"
								+ "Username VARCHAR(50) UNIQUE,"
								+ "Password VARCHAR(20) NOT NULL"
								+ "); ";
			
			Statement st = con.createStatement();
			st.executeUpdate(loginTable);
				System.out.println("Table 'Login' Created");
		}
		catch(Exception e)
		{
			System.out.println("CreateTables Login Exception: " + e);
		}
		
		
	//Create Student_Personal_Detail Table in hireupv1 database
		try
		{	
			String spdTable= "CREATE TABLE Student_Personal_Detail"
							+ "("
							+ "StuEmail VARCHAR(320) UNIQUE, "				//student email (collected from login table)
							+ "StuFirstName VARCHAR(50) NOT NULL, "     	//Student first name
							+ "StuLastName VARCHAR(50) NOT NULL, "      	//Student Last name 
							+ "StuBirthDate VARCHAR(12) NOT NULL, "			//Student Birth Date in varchar (Date format validation is done in front end part, while user filling form)
							+ "StuAge INT NOT NULL, "						//Student Age in integer (number)
							+ "StuMobile VARCHAR(20) NOT NULL, "			//Student Mobile Number with in Indian format with country code
							+ "StuGender ENUM('F', 'M', 'O') NOT NULL, "	//Student Gender (only M, F, O are allowed)
							+ "StuAddress VARCHAR(300) NOT NULL ,"			//Student Address (max 300 characters)
							+ "StuCity VARCHAR(50) NOT NULL, "				//Student City name
							+ "StuCountry VARCHAR(50) NOT NULL, "			//Student country name
							+ "StuAbout VARCHAR(500) NOT NULL ,"			//More About Student (max 500 characters)
							+ "FOREIGN KEY (StuEmail) REFERENCES Login(Email) "	//Student email foreign key reference
							+ "); ";
			
			Statement st = con.createStatement();
			st.executeUpdate(spdTable);
				System.out.println("Table 'Student_Personal_Detail' Created");
		}
		catch(Exception e)
		{
			System.out.println("CreateTables Student_Personal_Detail Exception: " + e);
		}
		
		
	//Create Student_Academic_Detail Table in hireupv1 database
		try
		{	
			String spdTable= "CREATE TABLE Student_Academic_Detail"
							+ "("
							+ "StuEmail VARCHAR(320) UNIQUE, "										//Student email (collected from login table)
							+ "StuRollNo INT, "														//Student college roll no
							+ "StuCourse ENUM('BBA', 'BBA(CA)', 'BBA(GeB)', 'BBA(IB)') NOT NULL,"	//Student Course with pre-defined allowed values
							
							+ "10th_University_Name VARCHAR(300) NOT NULL ,"						//Student 10th University Name (maxlength 300 character)
							+ "10th_School_Name VARCHAR(300) NOT NULL ,"							//Student 10th School Name (maxlength 300 character)
							+ "10th_Grade ENUM('A', 'B', 'C', 'D') NOT NULL, "						//Student 10th grade with pre-defined allowed values
							+ "10th_Start_Pass_Year VARCHAR(15) NOT NULL ,"							//Student 10th start pass year (maxlength 15 character)
							
							+ "12th_University_Name VARCHAR(300) NOT NULL ,"						//Student 12th University Name (maxlength 300 character)
							+ "12th_College_Name VARCHAR(300) NOT NULL ,"							//Student 12th School Name (maxlength 300 character)
							+ "12th_Grade ENUM('A', 'B', 'C', 'D') NOT NULL, "						//Student 12th grade with pre-defined allowed values
							+ "12th_Start_Pass_Year VARCHAR(15) NOT NULL ,"							//Student 12th start pass year (maxlength 15 character)
							
							+ "College_University_Name VARCHAR(300) NOT NULL ,"						//Student college University Name (maxlength 300 character)
							+ "College_Name VARCHAR(300) NOT NULL ,"								//Student college School Name (maxlength 300 character)
							+ "College_Aggregate ENUM('A', 'B', 'C', 'D') NOT NULL, "				//Student College Aggregate with pre-defined allowed values
							+ "College_Start_Pass_Year VARCHAR(15) NOT NULL ,"						//Student college start pass year (maxlength 15 character)
							
							+ "HireUpStatus ENUM('Not-Selected', 'Selected') NOT NULL DEFAULT 'Not-Selected', "	//Store student HireUp-Staus whether they are selected or Not-Selected by any company
							
							+ "PRIMARY KEY (StuRollno, StuCourse), "								//Composite primary key, combination of StuRollno and StuCourse
							+ "FOREIGN KEY (StuEmail) REFERENCES Login(Email) "						//Student email foreign key reference
							+ "); ";
			
			Statement st = con.createStatement();
			st.executeUpdate(spdTable);
				System.out.println("Table 'Student_Academic_Detail' Created");
		}
		catch(Exception e)
		{
			System.out.println("CreateTables Student_Academic_Detail Exception: " + e);
		}
		
		
	//Create Skills Table in hireupv1 database
		try
		{	
			String skillsTable =  "CREATE TABLE Skills "
									+ "("
									+ "StuEmail VARCHAR(320) UNIQUE,"			//Student email (collected from login table)
									+ "HTML INT NOT NULL, "						//Student HTML skills value (1% to 100%)
									+ "CSS INT NOT NULL, "						//Student CSS skills value (1% to 100%)
									+ "JavaScript INT NOT NULL, "				//Student JavaScript skills value (1% to 100%)
									+ "C INT NOT NULL,"							//Student C skills value (1% to 100%)
									+ "CPP INT NOT NULL,"						//Student CPP skills value (1% to 100%)
									+ "Java INT NOT NULL, "						//Student Java skills value (1% to 100%)
									+ "Sports INT NOT NULL, "					//Student Sports skills value (1% to 100%)
									+ "Animation INT NOT NULL,"					//Student Animation skills value (1% to 100%)
									+ "Act INT NOT NULL, "						//Student Act skills value (1% to 100%)
									+ "Photography INT NOT NULL, "				//Student Photography skills value (1% to 100%)
									+ "SocialMedia INT NOT NULL, "				//Student SocialMedia skills value (1% to 100%)
									+ "Art INT NOT NULL, "						//Student Art skills value (1% to 100%)
									
									+ " FOREIGN KEY (StuEmail) REFERENCES Login(Email) "	//Student email foreign key reference
									+ "); ";
			
			Statement st = con.createStatement();
			st.executeUpdate(skillsTable);
				System.out.println("Table 'Skills' Created");	
		}
		catch(Exception e)
		{
			System.out.println("CreateTables Skills Exception: " + e);
		}
		
		
	//Create Company Table in hireupv1 database
		try
		{	
			String CompanyTable =  "CREATE TABLE Company "
									+ "("
									+ "StuEmail VARCHAR(320) UNIQUE,"									//Student email (collected from login table)
									+ "CompanyName VARCHAR(500) NOT NULL ,"								//Company Name in which student is hired
									+ "JoiningDate VARCHAR(20) NOT NULL ,"								//Company Joining Date
									+ "Package VARCHAR(20) NOT NULL ,"									//Package value
									+ "OfferLetterStatus ENUM('Recieved', 'Not-Recieved') NOT NULL ,"	//OfferLetterStatus whether Recieved or Not-Recieved

									+ " FOREIGN KEY (StuEmail) REFERENCES Login(Email) "				//Student email foreign key reference
									+ "); ";
			
			Statement st = con.createStatement();
			st.executeUpdate(CompanyTable);
				System.out.println("Table 'Company' Created");	
		}
		catch(Exception e)
		{
			System.out.println("CreateTables Company Exception: " + e);
		}
		
	//Create Contacts Table in hireupv1 database
		try
		{	
			String contactsTable =  "CREATE TABLE Contacts "
									+ "("
									+ "ContactName VARCHAR(50) NOT NULL, "
									+ "ContactEmail VARCHAR(320) NOT NULL, "
									+ "ContactPlace VARCHAR(20) NOT NULL, "
									+ "ContactComment LONGTEXT, "
									+ "ContactStatus VARCHAR(20) NOT NULL DEFAULT 'unread' "
									+ "); ";
			
			Statement st = con.createStatement();
			st.executeUpdate(contactsTable);
				System.out.println("Table 'Contacts' Created");	
		}
		catch(Exception e)
		{
			System.out.println("CreateTables Contacts Exception: " + e);
		}
		
	} //main() method close

} //class CreateTables close
