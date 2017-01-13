
<?php
    include('../data/dbfile.php');
	session_start();
	$subject ="";
	$title = "";
	$body = "";
	$msg = "";

	if(isset($_POST['create']))
	{	    
		
		
		Get_Data();
		
		if(insert_blog($subject, $title, $body))
		{
			$msg = 'Blog has been created';
		}
			
		elseif (isset($_POST['clear']))
	   {
		clear_screen();
		header('Location: ../index.php');
	   }
	}
	
	function Get_Data()
	{
		global $subject, $title, $body;
		$subject = $_POST['subjecttopic'];
		$title = $_POST['ttitle'];
		$body = $_POST['blog'];
	}
    
			
	function insert_blog($subject,$title,$body)
{
global $connection, $rows, $retrieved;
	$sql = "call insert_blog('$subject','$title','$body')";


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

				
	
	
 

	
 
?>