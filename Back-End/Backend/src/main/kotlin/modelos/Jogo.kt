package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class Jogo(val codigoDoJogo: String?,val codigoDoUsuario: String?, val emailDoUsuario: String?, val senhaDoUsuario: String?, val nome: String?, val clacssificacaoEtaria: Int?, val publisher: String?, val anoDeLancamento: Int?, val resumo: String?,val urlImagem: String?, val generos: List<String>?, val plataformas: List<String>?)
