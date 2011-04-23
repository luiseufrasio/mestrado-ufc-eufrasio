CREATE TABLE Publisher (
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    primary key(name)
);

CREATE TABLE Recorder (
    recname VARCHAR(100) NOT NULL,
    primary key(recname)
);

CREATE TABLE Product (
    title VARCHAR(50) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    currency VARCHAR(20) NOT NULL,
    isbn VARCHAR(20) NULL,
    author VARCHAR(100) NULL,
    type VARCHAR(10) NOT NULL,
    publisher VARCHAR(100) NULL,
    recorder VARCHAR(100) NULL,
    PRIMARY KEY(title),
    FOREIGN KEY(publisher)
        REFERENCES Publisher(name),
    FOREIGN KEY(recorder)
        REFERENCES Recorder(recname)
);

INSERT INTO Publisher
    VALUES ('CAMPUS', 'Rua 7 Setembro, 111 an 16- Centro - Rio de Janeiro - RJ');
    
INSERT INTO Product
    VALUES ('VERDADES FUNDAMENTAIS SOBRE A NATUREZA DO LÍDER', 59.9, 'REAL', '978-85-352-4150-1', 'Barry Posner', 'book', 'CAMPUS', null);

INSERT INTO Recorder
    VALUES ('Universal Music Argentina S.A.');

INSERT INTO Product
    VALUES ('TUDO AZUL', 1.5, 'REAL', null, null, 'music', null, 'Universal Music Argentina S.A.');
    
INSERT INTO Product
    VALUES ('Kindle', 139, 'DOLAR', null, null, 'pc-hw', null, null);
