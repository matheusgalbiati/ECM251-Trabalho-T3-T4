package com.example.rotas

import com.example.funcoes.FuncoesGenero
import com.example.modelos.GeneroEUsuario
import io.ktor.application.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.rotasDoGenero(connection:java.sql.Connection) {
    route("/genero/") {
        get {
            call.respond(FuncoesGenero().pegarTodosOsGeneros(connection))
        }
        post {
            val generoData = call.receive<GeneroEUsuario>()
            call.respond(FuncoesGenero().criarNovoGenero(connection,generoData))
        }
    }
}