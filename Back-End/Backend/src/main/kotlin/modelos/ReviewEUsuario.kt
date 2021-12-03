package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class ReviewEUsuario(val codigoDoJogo: String?, val codigoDoUsuario: String?, val emailDoUsuario: String?, val senhaDoUsuario: String?, val estrelas: Int?, val texto: String?)
