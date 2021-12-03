package com.example.modelos

import kotlinx.serialization.Serializable

@Serializable
data class RespostaReview(val status:String, val reviews: List<Review>?, val justificativa: String?)
