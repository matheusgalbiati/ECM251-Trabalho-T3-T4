package com.example.funcoes

import com.example.modelos.*

const val NOME_TABELA_REVIEWS = "Reviews"
const val NOME_TABELA_JOGOS = "Jogos"

class FuncoesReview {
    // Pega Reviews Pelo Codigo Do Jogo
    fun pegarReviews(connection: java.sql.Connection, codigoJogo: String?): RespostaReview {
        if (codigoJogo == null)
            return RespostaReview("erro",null,"Codigo Do Jogo Não Informado")

        if (!codigoDoJogoEstaNoDB(connection,codigoJogo))
            return RespostaReview("erro",null,"Codigo Do Jogo Não Está Registrado")

        var listaOfReviews = mutableListOf<Review>()

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeQuery("SELECT * FROM ${NOME_TABELA_REVIEWS} WHERE CodigoDoJogo = \"${codigoJogo}\"")

        while (resultSet.next())
            listaOfReviews.add(Review(codigoJogo,resultSet.getString("CodigoDoUsuario"),resultSet.getInt("Estrelas"),resultSet.getString("Texto"),resultSet.getString("Data")))

        return RespostaReview("aceito",listaOfReviews,null)
    }

    // Cria Nova Review
    fun criarNovoReview(connection:java.sql.Connection,review: ReviewEUsuario): RespostaReview {
        val usuario = Usuario(review.codigoDoUsuario,null,null,review.emailDoUsuario,review.senhaDoUsuario,null,null)

        if (algumaInformacaoEstaFaltando(review))
            return RespostaReview("erro",null,"Inforcação(ões) Do Review Faltando")

        if (!FuncoesUsuario().infosTotaisDoUsuarioFornecidas(usuario))
            return RespostaReview("erro",null,"Inforcação(ões) Do Usuario Faltando")

        if (!codigoDoJogoEstaNoDB(connection,review.codigoDoJogo))
            return RespostaReview("erro",null,"Código Do Jogo Não Está Registrado")

        if (codigoDoUsuarioJaFezReviewDesseJogo(connection,usuario.codigo,review.codigoDoJogo))
            return RespostaReview("erro",null,"Usuario Já Tem Uma Review Desse Jogo")

        if (!FuncoesUsuario().credenciasBatem(connection,usuario,usuario.codigo))
            return RespostaReview("erro",null,"Credencias Não Bateram")


        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeUpdate("INSERT INTO ${NOME_TABELA_REVIEWS} VALUES (${review.estrelas},\"${review.texto}\",CURRENT_TIMESTAMP,\"${review.codigoDoJogo}\",\"${usuario.codigo}\")")

        return if (resultSet == 1)
            RespostaReview("aceito",null,null)
        else
            RespostaReview("erro",null,"Erro Ao Registrar Review")
    }

    // Checa Se O Codigo Do Jogo Esta No DB
    fun codigoDoJogoEstaNoDB(connection:java.sql.Connection,codigo: String?):Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo FROM ${NOME_TABELA_JOGOS} WHERE Codigo = \"${codigo}\"")
        return resultSet.next()
    }

    // Checa Se Alguma Informação Da Review Não Foram Informadas
    fun algumaInformacaoEstaFaltando(review: ReviewEUsuario): Boolean {
        return review.codigoDoJogo == null || review.codigoDoUsuario == null || review.estrelas == null || review.texto == null
    }

    // Checa Se O Codigo Do Usuario Esta No DB
    fun codigoDoUsuarioJaFezReviewDesseJogo(connection:java.sql.Connection,codigoDoUsuario: String?,codigoDoJogo: String?):Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT CodigoDoUsuario FROM ${NOME_TABELA_REVIEWS} WHERE CodigoDoUsuario = \"${codigoDoUsuario}\" AND CodigoDoJogo = \"${codigoDoJogo}\"")
        return resultSet.next()
    }

    //Checa Quais Dados Serão Atualizadas
    fun dadosASeremAtualizadas(review: ReviewEUsuario):Map<String,String> {
        val dadosQueSeraoAtualizadas = mutableMapOf<String,String>()

        if (review.estrelas!=null)
            dadosQueSeraoAtualizadas["Estrelas"] = review.estrelas.toString()
        if (review.texto!=null)
            dadosQueSeraoAtualizadas["Texto"] = review.texto

        return dadosQueSeraoAtualizadas
    }

    // Checa Se O Dado Que Será Atualizado Pode Ser Um Inteiro
    fun dadoPodeSerInteiro(dado: String?): Boolean {
        try {
            val dadoEmInteiro = dado?.toInt()
            return true
        } catch (e: NumberFormatException) {
            return false
        }
    }

    // Atualiza As Informações Das Reviews
    fun atuaizarInfoReview(connection:java.sql.Connection,review: ReviewEUsuario): RespostaReview {
        val usuario = Usuario(review.codigoDoUsuario,null,null,review.emailDoUsuario,review.senhaDoUsuario,null,null)

        if (algumaInformacaoEstaFaltando(review))
            return RespostaReview("erro",null,"Inforcação(ões) Do Review Faltando")

        if (!FuncoesUsuario().infosTotaisDoUsuarioFornecidas(usuario))
            return RespostaReview("erro",null,"Inforcação(ões) Do Usuario Faltando")

        if (!codigoDoUsuarioJaFezReviewDesseJogo(connection,usuario.codigo,review.codigoDoJogo))
            return RespostaReview("erro",null,"Usuario Não Tem Review Desse Jogo")

        if (!FuncoesUsuario().credenciasBatem(connection,usuario,usuario.codigo))
            return RespostaReview("erro",null,"Credencias Não Bateram")


        val dadosQueSeraoAtualizadas = dadosASeremAtualizadas(review)

        var queryDeAtualizar = "UPDATE ${NOME_TABELA_REVIEWS} SET "

        for (chave in dadosQueSeraoAtualizadas.keys) {
            queryDeAtualizar += "${chave} = "
            if (dadoPodeSerInteiro(dadosQueSeraoAtualizadas[chave]))
                queryDeAtualizar += "${dadosQueSeraoAtualizadas[chave]},"
            else {
                queryDeAtualizar += "\"${dadosQueSeraoAtualizadas[chave]}\","
            }
        }

        queryDeAtualizar = queryDeAtualizar.substring(0, queryDeAtualizar.length - 1)

        queryDeAtualizar += " WHERE CodigoDoUsuario = \"${usuario.codigo}\" AND CodigoDoJogo = \"${review.codigoDoJogo}\""

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeUpdate(queryDeAtualizar)

        return if (resultSet == 1)
            RespostaReview("aceito",null,null)
        else
            RespostaReview("erro",null,"Erro Ao Atualizar Informação(ões) Do Review")
    }

    // Checa Se O Codigo Do Jogo Foi Fornecido
    fun codigoDoJogoFoiFornecido(review: ReviewEUsuario): Boolean {
        return review.codigoDoJogo != null
    }

    // Deleta Review
    fun deletarReview(connection:java.sql.Connection,review: ReviewEUsuario): RespostaReview {
        val usuario = Usuario(review.codigoDoUsuario,null,null,review.emailDoUsuario,review.senhaDoUsuario,null,null)

        if (!codigoDoJogoFoiFornecido(review))
            return RespostaReview("erro",null,"Código Do Jogo Faltando")

        if (!FuncoesUsuario().infosTotaisDoUsuarioFornecidas(usuario))
            return RespostaReview("erro",null,"Inforcação(ões) Do Usuario Faltando")

        if (!codigoDoUsuarioJaFezReviewDesseJogo(connection,usuario.codigo,review.codigoDoJogo))
            return RespostaReview("erro",null,"Usuario Não Tem Review Desse Jogo")

        if (!FuncoesUsuario().credenciasBatem(connection,usuario,usuario.codigo))
            return RespostaReview("erro",null,"Credencias Não Bateram")

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeUpdate("DELETE FROM ${NOME_TABELA_REVIEWS} WHERE CodigoDoUsuario = \"${usuario.codigo}\" AND CodigoDoJogo = \"${review.codigoDoJogo}\"")

        return if (resultSet == 1)
            RespostaReview("aceito",null,null)
        else
            RespostaReview("erro",null,"Erro Ao Deletar Review")
    }
}