<?php
/**
 * Database Configuration
 * This file contains database connection settings
 */

class Database
{
    // Database credentials
    private $host = "localhost";
    private $db_name = "student_task_tracker";
    private $username = "root";
    private $password = "";
    public $conn;

    /**
     * Get database connection
     * @return PDO connection object
     */
    public function getConnection()
    {
        $this->conn = null;

        try {
            // Create PDO connection with UTF-8 encoding
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";port=3307;dbname=" . $this->db_name,
                $this->username,
                $this->password
                );

            // Set character set to UTF-8
            $this->conn->exec("set names utf8");

            // Set error mode to exceptions
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        }
        catch (PDOException $exception) {
            $error_response = array(
                "success" => false,
                "message" => "Database connection error: " . $exception->getMessage()
            );
            echo json_encode($error_response);
            exit;
        }

        return $this->conn;
    }
}
