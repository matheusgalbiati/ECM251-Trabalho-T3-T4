CREATE TABLE IF NOT EXISTS Usuarios (
    Email TEXT not null, 
    Senha varchar(512) not null,
    Nome TEXT not null,
    Sobrenome TEXT not null,
    Codigo varchar(30) not null
    );
