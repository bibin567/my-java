package com.example.myjavaproject;

import static spark.Spark.*;

public class Main {
    public static void main(String[] args) {
        port(8080); // Set the server port to 8080

        get("/", (req, res) -> "Hello, World!"); // Define a route and return a response
    }
}
