package com.example

import java.sql.DriverManager

val DB_URL = "jdbc:mysql://localhost:3306/projeto_T3_T4"
val DB_USER = "test"
val DB_PASS = "test"

fun conectarComODB():java.sql.Connection {
    return DriverManager.getConnection(DB_URL,DB_USER,DB_PASS)
}