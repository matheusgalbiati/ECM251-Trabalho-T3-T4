package com.example.rotas

import com.example.funcoes.FuncoesReview
import com.example.modelos.ReviewEUsuario
import io.ktor.application.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.rotasDoReview(connection:java.sql.Connection) {
    route("/review/") {
        get ("{codigo}") {
            val codigoJogo = call.parameters["codigo"]
            call.respond(FuncoesReview().pegarReviews(connection,codigoJogo))
        }
        post {
            val reviewData = call.receive<ReviewEUsuario>()
            call.respond(FuncoesReview().criarNovoReview(connection,reviewData))
        }
        put  {
            val reviewData = (call.receive<ReviewEUsuario>())
            call.respond(FuncoesReview().atuaizarInfoReview(connection,reviewData))
        }
        delete {
            val reviewData = (call.receive<ReviewEUsuario>())
            call.respond(FuncoesReview().deletarReview(connection,reviewData))
        }
    }
}