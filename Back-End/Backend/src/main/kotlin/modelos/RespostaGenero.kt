package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class RespostaGenero(val status:String,val generos: List<Genero>?,val justificativa: String?)
