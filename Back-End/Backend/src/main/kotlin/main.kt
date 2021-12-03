package com.example

import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.server.engine.*
import io.ktor.server.netty.Netty

import com.example.rotas.*

import io.ktor.features.*
import io.ktor.jackson.jackson

fun main() {
    //Cria uma conexão com o banco
    val connection = conectarComODB()
    embeddedServer(Netty, port = 8080, host = "0.0.0.0") {
        install(ContentNegotiation) {
            jackson()
        }
        routing {
            get("/") {
                call.respondText("Hello, world!")
            }
            // Parte Para Lidar Com Os Dados Dos Usuários
            rotasDoUsuario(connection)
            // Parte Para Lidar Com Os Dados Dos Generos
            rotasDoGenero(connection)
            // Parte Para Lidar Com Os Dados Das Plataformas
            rotasDaPlataforma(connection)
            // Parte Para Lidar Com Os Dados Dos Jogos
            rotasDoJogo(connection)
            // Parte Para Lidar Com Os Dados Dos Reviews
            rotasDoReview(connection)
            // Parte Para Lidar Com O Login Dos Reviews
            rotasDoLogin(connection)
        }
    }.start(wait = true)
}