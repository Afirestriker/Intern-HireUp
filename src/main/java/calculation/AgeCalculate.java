
/* This java file, is used to calculate user age */

package calculation;

/* 
 * java.time.LocalDate and java.time.Period class is imported for finding difference,
 * between user birthdate and current date in years and hence getting the age 
 * */
import java.time.*;

public class AgeCalculate {

	/* Static method of AgeCalculate class so that it can be called directory without need of an object 
	 * Public since, it can be called outside the package calculation
	 * */

	public static int age(String birthdate)
	{
		int age=0;
		
		/* Here, we are fetching year, month, day value from birthdate string
		 * using substring(start index, end index) method of String class
		 * NOTE: start index is inclusive, and end index is exclusive
		 *  */
		int year = Integer.parseInt(birthdate.substring(0,4));
		int month = Integer.parseInt(birthdate.substring(5,7));
		int day = Integer.parseInt(birthdate.substring(8));		/* using substring(start index) String function */
	
		/* bod will store birthdate value */
		LocalDate bod = LocalDate.of(year, month, day);
		
		/* now will store current year, month, date value */
		LocalDate now = LocalDate.now();
		
		/* Here, we create diff object of Period class, using which we can find age using getYears() method  */
		Period diff = Period.between(bod, now);
		
		/* In age, storing different between birthdate and now date, different in years storing in age */
		age = diff.getYears();
		
		/* return age, since function return value is int */
		return age;
	}

}
