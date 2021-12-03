package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class Review(val codigoDoJogo: String?, val codigoDoUsuario: String?, val estrelas: Int?, val texto: String?, val data: String?)
