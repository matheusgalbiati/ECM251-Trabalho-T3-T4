package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class RespostaJogo(val status:String,val codigosDosJogos: List<Any>?,val codigoDoJogo: String?,val codigoDoUsuario: String?, val nome: String?, val clacssificacaoEtaria: Int?, val publisher: String?, val anoDeLancamento: Int?, val resumo: String?, val estrelas: Float?, val generos: List<Any>?, val plataformas: List<Any>?, val urlImagem: String?,val justificativa: String?)