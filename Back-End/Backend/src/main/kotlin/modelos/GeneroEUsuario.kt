package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class GeneroEUsuario(val nome:String,val codigoDoUsuario:String,val email:String,val senha:String)
