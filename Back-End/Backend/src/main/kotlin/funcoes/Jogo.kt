package com.example.funcoes

import com.example.modelos.*
import kotlin.random.Random
import java.sql.PreparedStatement

const val NOME_TABELA_JOGOSxGENEROS = "JogosxGeneros"
const val NOME_TABELA_JOGOSxPLATAFORMAS = "JogosxPlataformas"
const val NOME_TABELA_GENEROS = "Generos"
const val NOME_TABELA_PLATAFORMAS = "Plataformas"

class FuncoesJogo {
    // Pega Jogo Pelo Codigo
    fun pegarJogo(connection: java.sql.Connection, codigoJogo: String?): RespostaJogo {
        if (codigoJogo == null)
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Codigo Do Jogo Não Informado")

        if (!codigoDoJogoEstaNoDB(connection,codigoJogo))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Codigo Do Jogo Não Está Registrado")

        var listaDeGeneros = mutableListOf<Genero>()
        var listaDePlataformas = mutableListOf<Plataforma>()
        var estrelas: Float? = null

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSetTabelaEstrelas = sqlStatement.executeQuery("SELECT AVG(Estrelas) FROM ${NOME_TABELA_REVIEWS} Where CodigoDoJogo = \"${codigoJogo}\"")
        if (resultSetTabelaEstrelas.next())
            estrelas = resultSetTabelaEstrelas.getFloat(1)


        val resultSetTabelaGeneros = sqlStatement.executeQuery("SELECT Codigo,Nome FROM ${NOME_TABELA_GENEROS} WHERE Codigo IN (SELECT CodigoDoGenero FROM ${NOME_TABELA_JOGOSxGENEROS} WHERE CodigoDoJogo = \"${codigoJogo}\")")
        while (resultSetTabelaGeneros.next())
            listaDeGeneros.add(Genero(resultSetTabelaGeneros.getString(1),resultSetTabelaGeneros.getString(2)))

        val resultSetTabelaPlataformas = sqlStatement.executeQuery("SELECT Codigo,Nome FROM ${NOME_TABELA_PLATAFORMAS} WHERE Codigo IN (SELECT CodigoDaPlataforma FROM ${NOME_TABELA_JOGOSxPLATAFORMAS} WHERE CodigoDoJogo = \"${codigoJogo}\")")
        while (resultSetTabelaPlataformas.next())
            listaDePlataformas.add(Plataforma(resultSetTabelaPlataformas.getString(1),resultSetTabelaPlataformas.getString(2)))

        val resultSetTabelaGeral = sqlStatement.executeQuery("SELECT * FROM ${NOME_TABELA_JOGOS} WHERE Codigo = \"${codigoJogo}\"")

        return if (resultSetTabelaGeral.next())
            RespostaJogo("aceito",null,codigoJogo,resultSetTabelaGeral.getString("CodigoDoUsuario"),resultSetTabelaGeral.getString("Nome"),resultSetTabelaGeral.getInt("ClassificacaoEtaria"),resultSetTabelaGeral.getString("Publisher"),resultSetTabelaGeral.getInt("AnoDeLancamento"),resultSetTabelaGeral.getString("Resumo"),estrelas,listaDeGeneros,listaDePlataformas,resultSetTabelaGeral.getString("UrlImagem"),null)
        else
            RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Erro Na Requisição")
    }

    // Pega Todos Os Codigos Dos Jogos
    fun pegarTodosOsIdsDosJogos(connection: java.sql.Connection): RespostaJogo {
        var listaDeIds = mutableListOf<String>()

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeQuery("SELECT Codigo FROM ${NOME_TABELA_JOGOS}")

        while (resultSet.next())
            listaDeIds.add(resultSet.getString("Codigo"))

        return RespostaJogo("aceito",listaDeIds,null,null,null,null,null,null,null,null,null,null,null,null)
    }

    // Cria Novo Jogo
    fun criarNovoJogo(connection: java.sql.Connection, jogo: Jogo): RespostaJogo {
        val usuario = Usuario(jogo.codigoDoUsuario,null,null,jogo.emailDoUsuario,jogo.senhaDoUsuario,null,null)

        if (algumaInformacaoEstaFaltando(jogo))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Inforcação(ões) Do Jogo Faltando")

        if (!FuncoesUsuario().infosTotaisDoUsuarioFornecidas(usuario))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Inforcação(ões) Do Usuario Faltando")

        if (!FuncoesUsuario().credenciasBatem(connection,usuario,usuario.codigo))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Credencias Não Bateram")

        if (!codigoDeGeneroEPlataformaEstaNoDB(connection,jogo.generos,jogo.plataformas))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Generos E/Ou Plataformas Não Registrados")

        var codigo: String

        do {
            codigo = criarCodigo()
        } while (codigoDoJogoEstaNoDB(connection,codigo))

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSetTabelaPrincipal = sqlStatement.executeUpdate("INSERT INTO ${NOME_TABELA_JOGOS} VALUES (\"${jogo.nome}\",${jogo.clacssificacaoEtaria},\"${jogo.publisher}\",${jogo.anoDeLancamento},\"${jogo.resumo}\",\"${jogo.urlImagem}\",\"${codigo}\",\"${usuario.codigo}\")")

        val sqlPreparedStatementGeneros: PreparedStatement = connection.prepareStatement("INSERT INTO ${NOME_TABELA_JOGOSxGENEROS} VALUES (?, ?)")

        for (genero in jogo.generos!!) {
            sqlPreparedStatementGeneros.clearParameters()
            sqlPreparedStatementGeneros.setString(1,codigo)
            sqlPreparedStatementGeneros.setString(2,genero)
            sqlPreparedStatementGeneros.addBatch()
        }

        val resultSetTabelaGeneros = sqlPreparedStatementGeneros.executeBatch()

        val sqlPreparedStatementPlataformas: PreparedStatement = connection.prepareStatement("INSERT INTO ${NOME_TABELA_JOGOSxPLATAFORMAS} VALUES (?, ?)")

        for (plataforma in jogo.plataformas!!) {
            sqlPreparedStatementPlataformas.clearParameters()
            sqlPreparedStatementPlataformas.setString(1,codigo)
            sqlPreparedStatementPlataformas.setString(2,plataforma)
            sqlPreparedStatementPlataformas.addBatch()
        }

        val resultSetTabelaPlataformas = sqlPreparedStatementPlataformas.executeBatch()

        return if (resultSetTabelaPrincipal == 1 && resultSetTabelaGeneros.all{it == 1} && resultSetTabelaPlataformas.all{it == 1})
            RespostaJogo("aceito", null,codigo, null, null, null, null, null, null, null, null,null, null,null)
        else
            RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Erro Ao Registrar Review")
    }

    // Checa Se Alguma Informações Está Faltando
    fun algumaInformacaoEstaFaltando(jogo: Jogo): Boolean{
        return jogo.codigoDoUsuario == null || jogo.emailDoUsuario == null || jogo.senhaDoUsuario == null || jogo.nome == null || jogo.clacssificacaoEtaria == null || jogo.publisher == null || jogo.anoDeLancamento == null || jogo.resumo == null
    }

    // Cria O Codigo Do Novo Jogo
    fun criarCodigo(): String{
        var codigo = ""

        for (i in 1..LENGTH_CODIGO_USUARIO) {
            val charDecVal = Random.nextInt(0, CHAR_DECIMAL_POSSIVEIS_VALORES.size)

            codigo += CHAR_DECIMAL_POSSIVEIS_VALORES[charDecVal].toChar()
        }

        return codigo
    }

    // Checa Se O Codigo Do Jogo Já Está No DB
    fun codigoDoJogoEstaNoDB(connection: java.sql.Connection,codigo: String): Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo FROM Jogos WHERE Codigo = \"${codigo}\"")
        return resultSet.next()
    }

    //Checa Quais Dados Serão Atualizadas
    fun dadosASeremAtualizadas(jogo: Jogo):Map<String,String> {
        val dadosQueSeraoAtualizadas = mutableMapOf<String,String>()

        if (jogo.nome!=null) (String)
            dadosQueSeraoAtualizadas["Nome"] = jogo.nome!!
        if (jogo.clacssificacaoEtaria!=null)
            dadosQueSeraoAtualizadas["ClassificacaoEtaria"] = jogo.clacssificacaoEtaria.toString()
        if (jogo.publisher!=null)
            dadosQueSeraoAtualizadas["Publisher"] = jogo.publisher
        if (jogo.anoDeLancamento!=null)
            dadosQueSeraoAtualizadas["AnoDeLancamento"] = jogo.anoDeLancamento.toString()
        if (jogo.resumo!=null)
            dadosQueSeraoAtualizadas["Resumo"] = jogo.resumo!!
        if (jogo.urlImagem!=null)
            dadosQueSeraoAtualizadas["UrlImagem"] = jogo.urlImagem!!

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

    // Atualiza As Informações Dos Jogos
    fun atuaizarInfoJogo(connection: java.sql.Connection, jogo: Jogo): RespostaJogo {
        val usuario = Usuario(jogo.codigoDoUsuario,null,null,jogo.emailDoUsuario,jogo.senhaDoUsuario,null,null)

        if (!FuncoesUsuario().infosTotaisDoUsuarioFornecidas(usuario))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Inforcação(ões) Do Usuario Faltando")

        if (!codigoDoUsuarioJaFezReviewDesseJogo(connection,usuario.codigo,jogo.codigoDoJogo))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Usuario Não Tem Review Desse Jogo")

        if (!FuncoesUsuario().credenciasBatem(connection,usuario,usuario.codigo))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Credencias Não Bateram")

        if (!codigoDeGeneroEPlataformaEstaNoDB(connection,jogo.generos,jogo.plataformas))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Generos E/Ou Plataformas Não Registrados")


        val dadosQueSeraoAtualizadas = dadosASeremAtualizadas(jogo)

        var queryDeAtualizar = "UPDATE ${NOME_TABELA_JOGOS} SET "

        for (chave in dadosQueSeraoAtualizadas.keys) {
            queryDeAtualizar += "${chave} = "
            if (dadoPodeSerInteiro(dadosQueSeraoAtualizadas[chave]))
                queryDeAtualizar += "${dadosQueSeraoAtualizadas[chave]},"
            else {
                queryDeAtualizar += "\"${dadosQueSeraoAtualizadas[chave]}\","
            }
        }

        queryDeAtualizar = queryDeAtualizar.substring(0, queryDeAtualizar.length - 1)

        queryDeAtualizar += " WHERE CodigoDoUsuario = \"${usuario.codigo}\" AND Codigo = \"${jogo.codigoDoJogo}\""

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeUpdate(queryDeAtualizar)

        if (jogo.plataformas != null)
            if (jogo.plataformas.size > 0) {
                //Cria um caminho para realizar queries sql no banco
                val sqlStatementDeletarPlataformas = connection.createStatement()
                //Executa uma query de busca
                val resultSetDeletarPlataformas = sqlStatementDeletarPlataformas.executeUpdate("DELETE FROM ${NOME_TABELA_JOGOSxPLATAFORMAS} WHERE CodigoDoJogo = \"${jogo.codigoDoJogo}\";")

                val sqlPreparedStatementPlataformas: PreparedStatement = connection.prepareStatement("INSERT INTO ${NOME_TABELA_JOGOSxPLATAFORMAS} VALUES (?, ?)")

                for (plataforma in jogo.plataformas!!) {
                    sqlPreparedStatementPlataformas.clearParameters()
                    sqlPreparedStatementPlataformas.setString(1,jogo.codigoDoJogo)
                    sqlPreparedStatementPlataformas.setString(2,plataforma)
                    sqlPreparedStatementPlataformas.addBatch()
                }

                val resultSetTabelaPlataformas = sqlPreparedStatementPlataformas.executeBatch()
            }

        if (jogo.generos != null)
            if (jogo.generos.size > 0) {
                //Cria um caminho para realizar queries sql no banco
                val sqlStatementDeletarPlataformas = connection.createStatement()
                //Executa uma query de busca
                val resultSetDeletarPlataformas = sqlStatementDeletarPlataformas.executeUpdate("DELETE FROM ${NOME_TABELA_JOGOSxGENEROS} WHERE CodigoDoJogo = \"${jogo.codigoDoJogo}\";")

                val sqlPreparedStatementPlataformas: PreparedStatement = connection.prepareStatement("INSERT INTO ${NOME_TABELA_JOGOSxGENEROS} VALUES (?, ?)")

                for (genero in jogo.generos!!) {
                    sqlPreparedStatementPlataformas.clearParameters()
                    sqlPreparedStatementPlataformas.setString(1,jogo.codigoDoJogo)
                    sqlPreparedStatementPlataformas.setString(2,genero)
                    sqlPreparedStatementPlataformas.addBatch()
                }

                val resultSetTabelaPlataformas = sqlPreparedStatementPlataformas.executeBatch()
            }

        return if (resultSet == 1)
            RespostaJogo("aceito",null,null,null,null,null,null,null,null,null,null,null,null,null)
        else
            RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Erro Ao Atualizar Informação(ões) Do Review")
    }

    // Deleta Jogo
    fun deletarJogo(connection: java.sql.Connection, jogo: Jogo): RespostaJogo {
        val usuario = Usuario(jogo.codigoDoUsuario,null,null,jogo.emailDoUsuario,jogo.senhaDoUsuario,null,null)

        if (!codigoDoJogoFoiFornecido(jogo))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Código Do Jogo Faltando")

        if (!FuncoesUsuario().infosTotaisDoUsuarioFornecidas(usuario))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Inforcação(ões) Do Usuario Faltando")

        if (!codigoDoUsuarioJaFezReviewDesseJogo(connection,usuario.codigo,jogo.codigoDoJogo))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"O Jogo Não Foi Registrado Pelo Usuario")

        if (!FuncoesUsuario().credenciasBatem(connection,usuario,usuario.codigo))
            return RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Credencias Não Bateram")

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSetBase = sqlStatement.executeUpdate("DELETE FROM ${NOME_TABELA_JOGOS} WHERE CodigoDoUsuario = \"${usuario.codigo}\" AND Codigo = \"${jogo.codigoDoJogo}\"")

        var resultSetGeneros = 0;
        var resultSetPlataformas = 0;

        if (resultSetBase == 1) {
            resultSetGeneros =
                sqlStatement.executeUpdate("DELETE FROM ${NOME_TABELA_JOGOSxGENEROS} WHERE CodigoDoJogo = \"${jogo.codigoDoJogo}\"")
            resultSetPlataformas = sqlStatement.executeUpdate("DELETE FROM ${NOME_TABELA_JOGOSxPLATAFORMAS} WHERE CodigoDoJogo = \"${jogo.codigoDoJogo}\";")
        }

        return if (resultSetBase == 1 && resultSetGeneros > 0 && resultSetPlataformas > 0)
            RespostaJogo("aceito",null,null,null,null,null,null,null,null,null,null,null,null,null)
        else
            RespostaJogo("erro",null,null,null,null,null,null,null,null,null,null,null,null,"Erro Ao Deletar Review")
    }

    // O Codigo Foi Fornecido
    fun codigoDoJogoFoiFornecido(jogo:Jogo): Boolean {
        return jogo.codigoDoJogo != null
    }

    // Checa Se O Jogo Foi Registrado Pelo Usuario
    fun codigoDoUsuarioJaFezReviewDesseJogo(connection:java.sql.Connection,codigoDoUsuario: String?,codigoDoJogo: String?):Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT CodigoDoUsuario FROM ${NOME_TABELA_JOGOS} WHERE CodigoDoUsuario = \"${codigoDoUsuario}\" AND Codigo = \"${codigoDoJogo}\"")
        return resultSet.next()
    }

    // Checa Se O Codigo Do Genero E Plataforma Já Existe No DB
    fun codigoDeGeneroEPlataformaEstaNoDB(connection:java.sql.Connection,codigosDoGenero: List<String>?,codigosDoPlataforma: List<String>?):Boolean {
        val sqlStatement = connection.createStatement()
        var todosTemResultados = codigosDoGenero != null && codigosDoPlataforma != null
        if (codigosDoGenero != null) {
            for (codigoDeGenero in codigosDoGenero) {
                val resultSetGenero = sqlStatement.executeQuery("SELECT Codigo FROM ${NOME_TABELA_GENEROS} WHERE Codigo = \"${codigoDeGenero}\"")
                todosTemResultados = todosTemResultados && resultSetGenero.next()
            }
        }
        if (codigosDoPlataforma != null) {
            for (codigoDePlataforma in codigosDoPlataforma) {
                val resultSetPlataformas = sqlStatement.executeQuery("SELECT Codigo FROM ${NOME_TABELA_PLATAFORMAS} WHERE Codigo = \"${codigoDePlataforma}\"")
                todosTemResultados = todosTemResultados && resultSetPlataformas.next()
            }
        }
        return todosTemResultados
    }
}