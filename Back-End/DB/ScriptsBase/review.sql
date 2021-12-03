CREATE TABLE IF NOT EXISTS Reviews (
    Estrelas INT not null,
    Texto TEXT not null,
    Data DATETIME not null,
    CodigoDoJogo varchar(30) not null,
    CodigoDoUsuario varchar(30) not null
    );
