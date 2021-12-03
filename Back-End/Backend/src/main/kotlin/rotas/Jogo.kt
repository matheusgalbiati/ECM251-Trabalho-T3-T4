package com.example.rotas

import com.example.funcoes.FuncoesJogo
import com.example.modelos.Jogo
import io.ktor.application.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.rotasDoJogo(connection:java.sql.Connection) {
    route("/jogo/") {
        get ("{codigo}") {
            val codigoJogo = call.parameters["codigo"]
            call.respond(FuncoesJogo().pegarJogo(connection,codigoJogo))
        }
        get {
            call.respond(FuncoesJogo().pegarTodosOsIdsDosJogos(connection))
        }
        post {
            val jogoData = call.receive<Jogo>()
            call.respond(FuncoesJogo().criarNovoJogo(connection,jogoData))
        }
        put  {
            val jogoData = (call.receive<Jogo>())
            call.respond(FuncoesJogo().atuaizarInfoJogo(connection,jogoData))
        }
        delete {
            val jogoData = (call.receive<Jogo>())
            call.respond(FuncoesJogo().deletarJogo(connection,jogoData))
        }
    }
}