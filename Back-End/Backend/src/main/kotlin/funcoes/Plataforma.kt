package com.example.funcoes

import com.example.modelos.*
import kotlin.random.Random

class FuncoesPlataforma {
    // Pega Todos As Plataformas
    fun pegarTodasAsPlataformas(connection:java.sql.Connection):RespostaPlataforma {

        var listaDePlataformas = mutableListOf<Plataforma>()

        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo,Nome FROM ${NOME_TABELA_PLATAFORMAS}")
        while (resultSet.next())
            listaDePlataformas.add(Plataforma(resultSet.getString(1),resultSet.getString(2)))

        return RespostaPlataforma("aceito",listaDePlataformas,null)
    }

    // Registra Nova Plataforma
    fun criarNovaPlataforma(connection:java.sql.Connection, plataforma: PlataformaEUsuario): RespostaGenero {
        val usuario = Usuario(plataforma.codigoDoUsuario,null,null,plataforma.email,plataforma.senha,null,null)
        if (!FuncoesUsuario().credenciasBatem(connection, usuario,usuario.codigo))
            return RespostaGenero("erro",null,"Email E/Ou Senha Não Condizem Com O Codigo Enviado")

        var codigo: String

        do {
            codigo = criarCodigo()
        } while (codigoDaPlataformaEstaNoDB(connection,codigo))


        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeUpdate("INSERT INTO ${NOME_TABELA_PLATAFORMAS} VALUES (\"${codigo}\",\"${plataforma.nome}\")")

        return if (resultSet == 1)
            RespostaGenero("aceito", listOf<Genero>(Genero(codigo,plataforma.nome)),null)
        else
            RespostaGenero("erro",null,"Erro Ao Atualizar Informação(ões) Do Usuario")
    }

    // Cria O Codigo Do Novo Genero
    fun criarCodigo(): String{
        var codigo = ""

        for (i in 1..LENGTH_CODIGO_USUARIO) {
            val charDecVal = Random.nextInt(0, CHAR_DECIMAL_POSSIVEIS_VALORES.size)

            codigo += CHAR_DECIMAL_POSSIVEIS_VALORES[charDecVal].toChar()
        }

        return codigo
    }

    // Checa Se O Codigo Esta No DB
    fun codigoDaPlataformaEstaNoDB(connection:java.sql.Connection,codigo: String):Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo FROM ${NOME_TABELA_PLATAFORMAS} WHERE Codigo = \"${codigo}\"")
        return resultSet.next()
    }
}