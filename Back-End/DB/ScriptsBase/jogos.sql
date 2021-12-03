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
