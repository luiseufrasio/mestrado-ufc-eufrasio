CREATE TABLE Seller (
    name VARCHAR(100) NOT NULL,
    primary key(name)
);

CREATE TABLE Product (
    type VARCHAR(10) NOT NULL,
    title VARCHAR(100) NOT NULL,
    condit VARCHAR(10),
    author VARCHAR(100),
    year INT,
    publisher VARCHAR(100),
    PRIMARY KEY(title)
);

CREATE TABLE Offer (
    id INT NOT NULL,
    qty INT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    currency VARCHAR(20) NOT NULL,
    seller VARCHAR(100) NOT NULL,
    product VARCHAR(100) NOT NULL,
    FOREIGN KEY(seller)
        REFERENCES Seller(name),
    FOREIGN KEY(product)
        REFERENCES Product(title),
    primary key(id)
);

CREATE VIEW S_Book AS
SELECT title as s_title, publisher as s_pub
FROM Product
WHERE type='book';

CREATE VIEW S_Publ AS
SELECT DISTINCT publisher as s_name
FROM Product
WHERE type='book';

CREATE VIEW S_Music AS
SELECT title as s_title
FROM Product
WHERE type='music';

INSERT INTO Seller
    VALUES ('Chico Buarque de Holanda');
    
INSERT INTO Product
    VALUES ('book', 'HISTORIAS DE CANCOES - CHICO BUARQUE', 'novo', 'Wagner Homem', 2009, 'Leya Brasil');
    
INSERT INTO Product
    VALUES ('book', 'Chico Buarque Letra E Musica, V.1', 'novo', 'Chico Buarque', 2004, 'Companhia das Letras');

INSERT INTO Product
    VALUES ('book', 'O Livro das Religioes', 'novo', 'Jostein Gaarder', 2000, 'Companhia das Letras');
    
INSERT INTO Product
    VALUES ('music', 'A BANDA', 'antiga', 'Chico Buarque', null, null);
    
INSERT INTO Product
    VALUES ('music', 'ANOS DOURADOS', 'antiga', 'Chico Buarque', null, null);
    
INSERT INTO Product
    VALUES ('music', 'O QUE SERA', 'antiga', 'Chico Buarque', null, null);