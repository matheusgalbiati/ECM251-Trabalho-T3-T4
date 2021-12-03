package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class RespostaPlataforma(val status:String,val plataformas: List<Plataforma>?,val justificativa: String?)
