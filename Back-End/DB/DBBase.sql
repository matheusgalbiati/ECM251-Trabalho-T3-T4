 CREATE TABLE IF NOT EXISTS Generos (
    Codigo varchar(30) not null,
    Nome TEXT not null
    );

CREATE TABLE IF NOT EXISTS Jogos (
    Nome TEXT not null,
    ClassificacaoEtaria INT not null,
    Publisher TEXT not null,
    AnoDeLancamento INT not null,
    Resumo TEXT not null,
    UrlImagem TEXT not null,
    Codigo varchar(30) not null,
    CodigoDoUsuario varchar(30) not null
    );

CREATE TABLE IF NOT EXISTS JogosxGeneros (
    CodigoDoJogo varchar(30) not null,
    CodigoDoGenero varchar(30) not null
    );

CREATE TABLE IF NOT EXISTS JogosxPlataformas (
    CodigoDoJogo varchar(30) not null,
    CodigoDaPlataforma varchar(30) not null
    );

 CREATE TABLE IF NOT EXISTS Plataformas (
    Codigo varchar(30) not null,
    Nome TEXT not null
    );

CREATE TABLE IF NOT EXISTS Reviews (
    Estrelas INT not null,
    Texto TEXT not null,
    Data DATETIME not null,
    CodigoDoJogo varchar(30) not null,
    CodigoDoUsuario varchar(30) not null
    );
	
CREATE TABLE IF NOT EXISTS Usuarios (
    Email TEXT not null, 
    Senha varchar(512) not null,
    Nome TEXT not null,
    Sobrenome TEXT not null,
    Codigo varchar(30) not null
    );