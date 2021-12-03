package com.example.rotas

import com.example.funcoes.FuncoesLogin
import com.example.modelos.Usuario
import io.ktor.application.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.rotasDoLogin(connection:java.sql.Connection) {
    route("/login/") {
        get {
            val loginData = call.receive<Usuario>()
            call.respond(FuncoesLogin().pegarInformacoesBasicasDeUmUsuario(connection,loginData))
        }
    }
}