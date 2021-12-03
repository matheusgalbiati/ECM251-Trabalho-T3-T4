package com.example.funcoes

import com.example.modelos.Usuario
import java.math.BigInteger
import java.security.MessageDigest
import kotlin.random.Random

import com.example.modelos.RespostaUsuario

class FuncoesLogin {
    // Pegar Informacoes Basicas De Um Usuario
    fun pegarInformacoesBasicasDeUmUsuario(connection:java.sql.Connection,usuario: Usuario?): RespostaUsuario {
        if (!infosTotaisDoUsuarioFornecidas(usuario))
            return RespostaUsuario("erro",null,null,null,null,"Inforcação(ões) Faltando")

        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo FROM Usuarios WHERE Email = \"${usuario?.email}\" AND Senha = \"${criarHashSHA512(usuario?.senha)}\"")

        return if (resultSet.next())
            RespostaUsuario("aceito",resultSet.getString("Codigo"),null,null,usuario?.email,null)
        else
            RespostaUsuario("erro",null,null,null,null,"Usuario Não Encontrado")
    }

    // Checa Se O Email E A Senha Do Usuario Foram Fornecidos Para Que Mais Informacos Possam Ser Pegas
    fun infosTotaisDoUsuarioFornecidas(usuario: Usuario?):Boolean {
        return usuario?.email != null && usuario?.senha != null
    }

    // Cria SHA-512 Para Mascarar Informações
    fun criarHashSHA512(stringParaHASH: String?):String{
        val md: MessageDigest = MessageDigest.getInstance("SHA-512")
        val messageDigest = md.digest((stringParaHASH + HASH_SALT).toByteArray())

        // Convert byte array into signum representation
        val no = BigInteger(1, messageDigest)

        // Convert message digest into hex value
        var hashtext: String = no.toString(16)

        // Add preceding 0s to make it 32 bit
        while (hashtext.length < 32)
            hashtext = "0$hashtext"

        // return the HashText
        return hashtext
    }
}