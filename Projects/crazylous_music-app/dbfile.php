<?php
	$user ='root';
	$pass = '';
	$db = 'crazylou';	
	$connection = new mysqli('localhost',$user,$pass,$db) or die(mysqli_error());	
?>