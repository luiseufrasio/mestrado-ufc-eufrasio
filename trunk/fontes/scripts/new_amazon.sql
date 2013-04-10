CREATE TABLE Estudio (
    nome VARCHAR(45) NOT NULL,
    gravadora VARCHAR(45) NOT NULL,
    primary key(nome)
);

CREATE TABLE Musica (
    descricao VARCHAR(255) NOT NULL,    
    valor DECIMAL(15,2) NOT NULL,
    condicao VARCHAR(45) NOT NULL,
    artista VARCHAR(45) NOT NULL,
    lancamento DATE NOT NULL,
    produzidaPor VARCHAR(45) NOT NULL,
    PRIMARY KEY(descricao),
    CONSTRAINT FK_ESTUDIO FOREIGN KEY(produzidaPor) REFERENCES Estudio(nome)
);

CREATE TABLE Livro (
    isbn VARCHAR(50) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    condicao VARCHAR(45) NOT NULL,
    autor VARCHAR(45) NOT NULL,
    edicao INT NOT NULL,
    editora VARCHAR(45) NOT NULL,
    enderecoEditora VARCHAR(255) NOT NULL,
    PRIMARY KEY(isbn)
);

CREATE TABLE Diretor (
    nome VARCHAR(45) NOT NULL,
    primary key(nome)
);

CREATE TABLE DVD (
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    condicao VARCHAR(45) NOT NULL,
    categoria VARCHAR(45) NOT NULL,
    temDiretor VARCHAR(45) NOT NULL,
    primary key(descricao),
    CONSTRAINT FK_DIRETOR FOREIGN KEY(temDiretor) REFERENCES Diretor(nome)
);

CREATE TABLE PC_Hardware (
    descricao VARCHAR(255) NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    condicao VARCHAR(45) NOT NULL,
    tipoCPU VARCHAR(45) NOT NULL,
    tamanhoHD DECIMAL(15,2) NOT NULL,
    PRIMARY KEY(descricao)
);