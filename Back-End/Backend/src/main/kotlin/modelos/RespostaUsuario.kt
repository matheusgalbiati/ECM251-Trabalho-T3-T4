package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class RespostaUsuario (val status:String,val codigo: String?, val nome: String?, val sobrenome: String?, val email: String?,val justificativa: String?)