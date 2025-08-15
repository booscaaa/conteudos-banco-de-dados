CREATE TABLE raca(
   id SERIAL PRIMARY KEY NOT NULL,
   nome VARCHAR(20) NOT NULL,
   data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cachorro(
   id SERIAL PRIMARY KEY NOT NULL,
   nome VARCHAR(20) NOT NULL,
   peso DECIMAL NOT NULL,
   altura DECIMAL NOT NULL,
   id_raca INTEGER NOT NULL,
   idade INT NOT NULL,
   data_nascimento DATE NOT NULL,
   data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

   CONSTRAINT id_raca_fk FOREIGN KEY (id_raca) REFERENCES raca(id)
);

INSERT INTO cachorro (nome, peso, altura, id_raca, idade, data_nascimento)
VALUES ('Bola', 10.5, 0.5, 1, 5, '2018-01-01');

