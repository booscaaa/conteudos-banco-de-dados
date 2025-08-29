CREATE TABLE livro (
    id SERIAL PRIMARY KEY NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    autor VARCHAR(50) NOT NULL
);

CREATE TABLE leitor (
    id SERIAL PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE retirada_livro (
    id SERIAL PRIMARY KEY NOT NULL,
    id_livro INTEGER NOT NULL,
    id_leitor INTEGER NOT NULL,
    data_retirada TIMESTAMP NOT NULL,
    data_devolucao TIMESTAMP NOT NULL,

    CONSTRAINT id_livro_fk FOREIGN KEY (id_livro) REFERENCES livro(id),
    CONSTRAINT id_leitor_fk FOREIGN KEY (id_leitor) REFERENCES leitor(id)
);

INSERT INTO livro (titulo, genero, autor) VALUES ('O Senhor dos Anéis', 'Fantasia', 'J.R.R. Tolkien');
INSERT INTO livro (titulo, genero, autor) VALUES ('A Sociedade do Anel', 'Fantasia', 'J.R.R. Tolkien');
INSERT INTO livro (titulo, genero, autor) VALUES ('O Retiro do Soldado Ryan', 'Ação', 'Martin Lawrence');


INSERT INTO leitor(nome) VALUES('Bruno');
INSERT INTO leitor(nome) VALUES('Caio');
INSERT INTO leitor(nome) VALUES('João');

SELECT * from livro;
SELECT * from leitor;

-- id_livro = 5, id_leitor = 3

INSERT INTO retirada_livro(id_livro, id_leitor, data_retirada, data_devolucao)
VALUES(5, 3, NOW(), NOW());

INSERT INTO retirada_livro(id_livro, id_leitor, data_retirada, data_devolucao)
VALUES(5, 2, NOW(), NOW());

SELECT * FROM retirada_livro;

SELECT lt.nome, l.titulo, r.data_retirada from retirada_livro r 
INNER JOIN livro l ON l.id = r.id_livro
INNER JOIN leitor lt ON lt.id = r.id_leitor
WHERE lt.id IN (1, 2);

