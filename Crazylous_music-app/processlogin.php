<?php
include('./dbfile.php');
session_start();
$browsersess = session_id();

$email = "";
$password = "";
$custID = "";

if(isset($_POST['email']) && isset($_POST['pswd']))

{ 
	$username = $_POST['email'];
	$password = $_POST['pswd'];
	//$email = trim($email);
	$password = trim($password);
	$password = md5($password);
	if(Verify_Login($username, $password)>0)
	{
	  
			if(Create_User_Session() > 0)
			{ 		
			    header('Location: landingpage.php');
      		}  
	  		 else
	    	{
		 header('Location:index.php');
	  		 }
	  	
	}
}
 function Create_User_Session()
 {
 	global $connection, $custID, $browsersess;
 	$sql = "call session_insert($custID, '$browsersess')";	
 	$connection->next_result();
	if($result = $connection->query($sql))
	{  
		return 1;
	}
	else
	{
		return 0;
	}
 }

 
function Verify_Login($username,$pswd)
{
global $connection, $custID;
$sql = "call customer_verify_login('$username','$pswd')";

         if($retrieved = $connection->query($sql))
         {
         	$rows = $retrieved->fetch_row();
         	$custID = $rows[0];
         	
         	return 1;

         }
         else
         {
         	return 0;
         }
}

?>