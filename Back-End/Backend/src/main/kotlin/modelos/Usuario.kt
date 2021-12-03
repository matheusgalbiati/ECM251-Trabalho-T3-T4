package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class Usuario (val codigo: String?, val nome: String?, val sobrenome: String?, val email: String?, val senha: String?, val emailParaTrocar: String?, val senhaParaTrocar: String?)