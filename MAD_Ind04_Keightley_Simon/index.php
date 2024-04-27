<?php
        //third pass using https://www.w3schools.com/php/php_mysql_select.asp
          $host = "mysql.cs.okstate.edu";
          $username = "skeight";
          $password = "luckyAl@rm94";
          $dbname = "skeight";
          
          try {
            $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $query = "SELECT name, nickname FROM states";
            $statement = $pdo->prepare($query);
            $statement->execute();
          
            // set the resulting array to associative
            $result = $statement->setFetchMode(PDO::FETCH_ASSOC);
            $statesArray = $statement->fetchAll();
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode($statesArray);
          } catch(PDOException $e) {
            echo "Error: " . $e->getMessage();
          }
          $pdo = null;
?>