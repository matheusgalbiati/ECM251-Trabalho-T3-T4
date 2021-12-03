package com.example.rotas

import io.ktor.application.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

import com.example.funcoes.FuncoesUsuario
import com.example.modelos.Usuario

fun Route.rotasDoUsuario(connection:java.sql.Connection) {
    route("/usuario/") {
        get ("{codigo}") {
            val codigoUsuario = call.parameters["codigo"]
            val usuarioData = call.receiveOrNull<Usuario>()
            if(FuncoesUsuario().infosTotaisDoUsuarioFornecidas(usuarioData)) {
                if(FuncoesUsuario().credenciasBatem(connection,usuarioData,codigoUsuario)) {
                    call.respond(FuncoesUsuario().pegarTodasInformacoesDeUmUsuario(connection,codigoUsuario))
                } else {
                    call.respond(FuncoesUsuario().pegarInformacoesBasicasDeUmUsuario(connection,codigoUsuario))
                }
            } else {
                call.respond(FuncoesUsuario().pegarInformacoesBasicasDeUmUsuario(connection,codigoUsuario))
            }
        }
        post {
            val usuarioData = (call.receive<Usuario>())
            call.respond(FuncoesUsuario().criarNovoUsuario(connection,usuarioData))
        }
        put () {
            val usuarioData = (call.receive<Usuario>())
            call.respond(FuncoesUsuario().atuaizarInfoUsuario(connection,usuarioData))
        }
    }
}