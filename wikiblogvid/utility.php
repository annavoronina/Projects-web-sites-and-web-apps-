<?php
	include('../data/dbfile.php');
	
	class myfunctions
	{
		public function validate_input($string)
		{			
			$string = trim($string);
			if(empty($string))			
			{
				return 0;
			}	
			else
			{
				return 1;
			}
			
		}
		public function verify_login($username,$password)
		{
			global $connection;
			$sql ="call users_verify_login('$username','$password')";			
			$connection->next_result();
			if($retrieved = $connection->query($sql))
			{
				
				echo $retrieved->num_rows;
				if($retrieved->num_rows)
				{
					echo "num rows";
					$row = $retrieved->fetch_row();
					return $row;
				}
				else
				{
					return 0;
				}
			}
		}
		// will check to see if email exists
		public function Check_Email_Exists($email)
		{
			global $connection;
			$sql = "call users_email_check('$email')";					
			$connection->next_result();
			if($retrieved = $connection->query($sql))
			{			
				if($retrieved->num_rows)
				{
					return 0 ; // email in use
				}
				else
				{
					return 1; // email not found
				}
			}
			else
			{	
			
				return 1 ; 
			}
		}
		// will check to see if user name exists
		public function Check_UserName($uname)
		{
			global $connection;
			$sql = "call users_check_username('$uname')";
			$connection->next_result();
			if($retrieved = $connection->query($sql))
			{
				if($retrieved->num_rows)
				{
					return 0;
				}
				else
				{
					return 1;
				}
			}
			else
			{
				return 0;
			}
		}
		
		// will save user (still need to save secret question)
		public function User_Insert($fname,$lname,$uname,$email,$pswd)
		{
			global $connection;
			$sql = "call users_insert('$fname','$lname','$uname','$email','$pswd')";
			$connection->next_result();
			if($retrieved = $connection->query($sql))
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
	} // end of class
?>