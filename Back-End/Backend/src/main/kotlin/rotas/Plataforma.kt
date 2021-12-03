package com.example.rotas

import com.example.funcoes.FuncoesPlataforma
import com.example.modelos.PlataformaEUsuario
import io.ktor.application.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.rotasDaPlataforma(connection:java.sql.Connection) {
    route("/plataforma/") {
        get {
            call.respond(FuncoesPlataforma().pegarTodasAsPlataformas(connection))
        }
        post {
            val plataformaData = call.receive<PlataformaEUsuario>()
            call.respond(FuncoesPlataforma().criarNovaPlataforma(connection,plataformaData))
        }
    }
}