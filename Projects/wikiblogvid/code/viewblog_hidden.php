<?php	
	session_start();
	if(isset($_SESSION['userid']))
	{
		$role = $_SESSION['role'];
		if($role == 1)
		{
			header('Location: ../public/viewblog.php'); 
		}
		else if($role ==2)
		{
		    
			header('Location: ../customer/createblog.php'); 
		}
	}
	
?>