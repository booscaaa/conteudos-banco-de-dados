CREATE DATABASE aula3;

CREATE TABLE usuario (
   id SERIAL PRIMARY KEY NOT NULL,
   login VARCHAR(20) NOT NULL UNIQUE,
   senha VARCHAR(50) NOT NULL,
   data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM usuario;

INSERT INTO usuario (login, senha) VALUES ('admin', '123456');

SELECT * FROM usuario WHERE login = 'admin';

UPDATE usuario SET senha = '123456789' WHERE login = 'admin';

SELECT * FROM usuario WHERE login = 'admin';

DELETE FROM usuario WHERE login = 'admin';

SELECT * FROM usuario;
