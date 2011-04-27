CREATE TABLE Publisher (
    id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    primary key(id)
);

CREATE TABLE Recorder (
    id INT NOT NULL,
    recname VARCHAR(100) NOT NULL,
    primary key(id)
);

CREATE TABLE Product (
    id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    currency VARCHAR(20) NOT NULL,
    isbn VARCHAR(20) NULL,
    author VARCHAR(100) NULL,
    type VARCHAR(10) NOT NULL,
    publisher INT NULL,
    recorder INT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(publisher)
        REFERENCES Publisher(id),
    FOREIGN KEY(recorder)
        REFERENCES Recorder(id)
);

INSERT INTO Publisher
    VALUES (1, 'CAMPUS', 'Rua 7 Setembro, 111 an 16- Centro - Rio de Janeiro - RJ');
    
INSERT INTO Product
    VALUES (1, 'VERDADES FUNDAMENTAIS SOBRE A NATUREZA DO LÍDER', 59.9, 'REAL', '978-85-352-4150-1', 'Barry Posner', 'book', 1, null);

INSERT INTO Recorder
    VALUES (1, 'Universal Music Argentina S.A.');

INSERT INTO Product
    VALUES (2, 'TUDO AZUL', 1.5, 'REAL', null, null, 'music', null, 'Universal Music Argentina S.A.');
    
INSERT INTO Product
    VALUES (3, 'Kindle', 139, 'DOLAR', null, null, 'pc-hw', null, null);
