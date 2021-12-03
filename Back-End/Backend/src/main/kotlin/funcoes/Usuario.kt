package com.example.funcoes

import com.example.modelos.Usuario
import java.math.BigInteger
import java.security.MessageDigest
import kotlin.random.Random

import com.example.modelos.RespostaUsuario

const val LENGTH_CODIGO_USUARIO = 10
val CHAR_DECIMAL_TODOS_VALORES = 33..125
val INVALID_CHAR_DECIMAL_VALORES = listOf(34,35,36,37,38,39,40,41,43,44,47,58,59,60,61,62,63,64,91,92,93,94,96,123,124,125)
val CHAR_DECIMAL_POSSIVEIS_VALORES = CHAR_DECIMAL_TODOS_VALORES - INVALID_CHAR_DECIMAL_VALORES

const val HASH_SALT = "@!(sdjaAerA1243(*2dDs"
class FuncoesUsuario {
    // Checa Se O Email E A Senha Do Usuario Foram Fornecidos Para Que Mais Informacos Possam Ser Pegas
    fun infosTotaisDoUsuarioFornecidas(usuario: Usuario?):Boolean {
        return usuario?.email != null && usuario?.senha != null
    }

    // Checa As Credencias Do Usuario
    fun credenciasBatem(connection:java.sql.Connection, usuario: Usuario?, codigo:String?):Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT * FROM Usuarios WHERE Email = \"${usuario?.email}\" AND Senha = \"${criarHashSHA512(usuario?.senha)}\" AND Codigo = \"${codigo}\"")
        return resultSet.next()
    }

    // Pegar Todas Informacoes De Um Usuario
    fun pegarTodasInformacoesDeUmUsuario(connection:java.sql.Connection,codigo:String?): RespostaUsuario {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo,Nome,Sobrenome,Email FROM Usuarios WHERE Codigo = \"${codigo}\"")

        return if (resultSet.next())
            RespostaUsuario("aceito",resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),resultSet.getString(4),null)
        else
            RespostaUsuario("erro",null,null,null,null,"Usuario Não Encontrado")
    }

    // Pegar Informacoes Basicas De Um Usuario
    fun pegarInformacoesBasicasDeUmUsuario(connection:java.sql.Connection,codigo:String?): RespostaUsuario {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo,Nome,Sobrenome,Email FROM Usuarios WHERE Codigo = \"${codigo}\"")

        return if (resultSet.next())
            RespostaUsuario("aceito",resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),resultSet.getString(4),null)
        else
            RespostaUsuario("erro",null,null,null,null,"Usuario Não Encontrado")
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

    // Cria Um Novo Usuario No Sistema
    fun criarNovoUsuario(connection:java.sql.Connection,usuario: Usuario): RespostaUsuario {
        if (algumaInformacaoDoUsuarioEstaFaltando(usuario))
            return RespostaUsuario("erro",null,null,null,null,"Falta De Informaçào(ões)")

        if (emailDoUsuarioEstaNoDB(connection,usuario.email))
            return RespostaUsuario("erro",null,null,null,null,"Email Ja Cadastrado")

        var codigo: String

        do {
            codigo = criarCodigo()
        } while (codigoDoUsuarioEstaNoDB(connection,codigo))

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeUpdate("INSERT INTO Usuarios VALUES (\"${usuario.email}\",\"${criarHashSHA512(usuario.senha)}\",\"${usuario.nome}\",\"${usuario.sobrenome}\",\"${codigo}\")")

        return if (resultSet == 1)
            RespostaUsuario("aceito",codigo,null,null,null,null)
        else
            RespostaUsuario("erro",null,null,null,null,"Erro Ao Registrar Usuario")
    }

    // Checa Se Alguma Infoarmcao Do Usuario Nao Foi Enviada Na Requisicao
    fun algumaInformacaoDoUsuarioEstaFaltando(usuario: Usuario): Boolean {
        return usuario.nome == null || usuario.sobrenome == null || usuario.email == null || usuario.senha == null
    }

    // Checa Se O Email Do Usuario Nao Esta No DB
    fun emailDoUsuarioEstaNoDB(connection:java.sql.Connection,email: String?):Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Email FROM Usuarios WHERE Email = \"${email}\"")
        return resultSet.next()
    }

    // Checa Se O Codigo Do Usuario Nao Esta No DB
    fun codigoDoUsuarioEstaNoDB(connection:java.sql.Connection,codigo: String):Boolean {
        val sqlStatement = connection.createStatement()
        val resultSet = sqlStatement.executeQuery("SELECT Codigo FROM Usuarios WHERE Codigo = \"${codigo}\"")
        return resultSet.next()
    }

    // Cria O Codigo Do Novo Usuario
    fun criarCodigo(): String{
        var codigo = ""

        for (i in 1..LENGTH_CODIGO_USUARIO) {
            val charDecVal = Random.nextInt(0, CHAR_DECIMAL_POSSIVEIS_VALORES.size)

            codigo += CHAR_DECIMAL_POSSIVEIS_VALORES[charDecVal].toChar()
        }

        return codigo
    }

    //Checa Quais Dados Serão Atualizadas
    fun dadosASeremAtualizadas(usuario: Usuario):Map<String,String> {
        val dadosQueSeraoAtualizadas = mutableMapOf<String,String>()

        if (usuario.nome!=null)
            dadosQueSeraoAtualizadas["Nome"] = usuario.nome
        if (usuario.sobrenome!=null)
            dadosQueSeraoAtualizadas["Sobrenome"] = usuario.sobrenome
        if (usuario.emailParaTrocar!=null)
            dadosQueSeraoAtualizadas["Email"] = usuario.emailParaTrocar
        if (usuario.senhaParaTrocar!=null)
            dadosQueSeraoAtualizadas["Senha"] = criarHashSHA512(usuario.senhaParaTrocar)

        return dadosQueSeraoAtualizadas
    }

    // Atualiza As Informações Do Usuario Se As credencias Necessarias Forem Apresentadas
    fun atuaizarInfoUsuario(connection:java.sql.Connection, usuario: Usuario) : RespostaUsuario {
        if (!emailDoUsuarioEstaNoDB(connection,usuario.email))
            return RespostaUsuario("erro",null,null,null,null,"Usuario Não Encontrado")

        if (!infosTotaisDoUsuarioFornecidas(usuario))
            return RespostaUsuario("erro",null,null,null,null,"Inforcação(ões) Faltando")

        if (!credenciasBatem(connection,usuario,usuario.codigo))
            return RespostaUsuario("erro",null,null,null,null,"Email E/Ou Senha Não Condizem Com O Codigo Enviado")

        val dadosQueSeraoAtualizadas = dadosASeremAtualizadas(usuario)

        var queryDeAtualizar = "UPDATE Usuarios SET "

        for (chave in dadosQueSeraoAtualizadas.keys)
            queryDeAtualizar += "${chave} = \"${dadosQueSeraoAtualizadas[chave]}\","

        queryDeAtualizar = queryDeAtualizar.substring(0, queryDeAtualizar.length - 1)

        queryDeAtualizar += " WHERE Codigo = \"${usuario.codigo}\""

        //Cria um caminho para realizar queries sql no banco
        val sqlStatement = connection.createStatement()
        //Executa uma query de busca
        val resultSet = sqlStatement.executeUpdate(queryDeAtualizar)

        return if (resultSet == 1)
            RespostaUsuario("aceito",usuario.codigo,null,null,null,null)
        else
            RespostaUsuario("erro",null,null,null,null,"Erro Ao Atualizar Informação(ões) Do Usuario")
    }
}