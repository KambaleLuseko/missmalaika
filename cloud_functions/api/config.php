<?php
header("Access-Control-Allow-Origin: *");
ini_set('upload_max_filesize', '50M');
ini_set('post_max_size', '55M');
class Constants
{
	static $DB_HOST = "localhost";
	static $DB_USER = "root";
	static $DB_PASS = "root";
	static $DB_NAME = "malaika";

	// static $DB_HOST = "be4kvgtdgmwtxvcct1cs-mysql.services.clever-cloud.com";
	// static $DB_USER = "uumuzezrqtwiu78v";
	// static $DB_PASS = "p8y0xE6sXzFCjkLigZBX";
	// static $DB_NAME = "be4kvgtdgmwtxvcct1cs";

	public static function connect()
	{
		$con = new mysqli("127.0.0.1", "root", "root", "malaika", 8889) or die("Unable to connect to database");
		if ($con->connect_error) {
			return null;
		} else {
			return $con;
		}
	}
}
