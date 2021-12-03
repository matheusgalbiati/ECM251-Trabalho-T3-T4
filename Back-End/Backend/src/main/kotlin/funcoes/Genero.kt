package com.example.funcoes

import com.example.modelos.*
import kotlin.random.Random

class FuncoesGenero {
    // Pega Todos Os Generos
    fun pegarTodosOsGeneros(connection:java.sql.Connection):RespostaGenero {

        var listaDeGeneros = mutableListOf<Genero>()

        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo,Nome FROM ${NOME_TABELA_GENEROS}")
        while (resultSet.next())
            listaDeGeneros.add(Genero(resultSet.getString(1),resultSet.getString(2)))

        return RespostaGenero("aceito",listaDeGeneros,null)
    }

    // Registra Novo Genero
    fun criarNovoGenero(connection:java.sql.Connection, genero:GeneroEUsuario): RespostaGenero {
        val usuario = Usuario(genero.codigoDoUsuario,null,null,genero.email,genero.senha,null,null)
        if (!FuncoesUsuario().credenciasBatem(connection, usuario,usuario.codigo))
            return RespostaGenero("erro",null,"Email E/Ou Senha Não Condizem Com O Codigo Enviado")

        var codigo: String

        do {
            codigo = criarCodigo()
        } while (codigoDoGeneroEstaNoDB(connection,codigo))


        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeUpdate("INSERT INTO ${NOME_TABELA_GENEROS} VALUES (\"${codigo}\",\"${genero.nome}\")")

        return if (resultSet == 1)
            RespostaGenero("aceito", listOf<Genero>(Genero(codigo,genero.nome)),null)
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
    fun codigoDoGeneroEstaNoDB(connection:java.sql.Connection,codigo: String):Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo FROM ${NOME_TABELA_GENEROS} WHERE Codigo = \"${codigo}\"")
        return resultSet.next()
    }
}