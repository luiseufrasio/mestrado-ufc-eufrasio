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
    primary key(id)
);

CREATE TABLE Book (
    idProd INT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    currency VARCHAR(20) NOT NULL,    
    isbn VARCHAR(20) NULL,
    idPubl INT NULL,
    PRIMARY KEY(idProd),
    CONSTRAINT FK_PROD_BOOK FOREIGN KEY(idProd) REFERENCES Product(id),
    CONSTRAINT FK_PUBL FOREIGN KEY(idPubl) REFERENCES Publisher(id)
);

CREATE TABLE Author (
    id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NULL,
    page VARCHAR(100) NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Author_Book (
    idAuthor INT NOT NULL,
    idBook INT NOT NULL,
    PRIMARY KEY(idAuthor, idBook),
    CONSTRAINT FK_AUTHOR_BOOK FOREIGN KEY(idAuthor) REFERENCES Author(id),
    CONSTRAINT FK_BOOK_AUTHOR FOREIGN KEY(idBook) REFERENCES Book(idProd)
);

CREATE TABLE Music (
    idProd INT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    currency VARCHAR(20) NOT NULL,    
    idRec INT NOT NULL,
    PRIMARY KEY(idProd),
    CONSTRAINT FK_PROD_MUSIC FOREIGN KEY(idProd) REFERENCES Product(id),
    CONSTRAINT FK_REC FOREIGN KEY(idRec) REFERENCES Recorder(id)
);

CREATE VIEW `s_product` AS 
select `product`.`id` AS `s_id`,`product`.`title` AS `s_title` 
from `product`;

CREATE VIEW `s_book` AS 
select 
    `b`.`idProd` AS `s_id`,
    `b`.`idPubl` AS `s_pub`,
    (select `p`.`title` 
     from `product` `p` 
     where (`p`.`id` = `b`.`idProd`)) AS `s_title` 
from 
    `book` `b`;
    
    

INSERT INTO Publisher
    VALUES (1, 'Manning Publications Co.', '20 Baldwin Road PO Box 261 Shelter Island, NY 11964');
    
INSERT INTO Product
    VALUES (1, 'Android in Action');
    
INSERT INTO Book
    VALUES (1, 49.99, 'USD', '9781935182726', 1);
    
INSERT INTO Author
    VALUES (1, 'W. Frank Ableson', 'frank@ableson.com', NULL);
    
INSERT INTO Author_Book
    VALUES (1, 1);
    
INSERT INTO Product
    VALUES (2, 'Hello! Python');
    
INSERT INTO Book
    VALUES (2, 34.99, 'USD', '9781935182085', 1);
    
INSERT INTO Author
    VALUES (3, 'Anthony Briggs', 'anthony@briggs.com', NULL);
    
INSERT INTO Author_Book
    VALUES (3, 2);

INSERT INTO Product
    VALUES (3, 'MongoDB in Action');
    
INSERT INTO Book
    VALUES (3, 44.99, 'USD', '9781935182870', 1);

INSERT INTO Author
    VALUES (2, 'Kyle Banker', 'kyle@banker.com', NULL);
    
INSERT INTO Author_Book
    VALUES (2, 3);

INSERT INTO Recorder
    VALUES (1, 'Sony Music Entertainment');

INSERT INTO Recorder
    VALUES (2, 'Universal Music Group');
    
INSERT INTO Product
    VALUES (4, 'One In A Million');

INSERT INTO Music
    VALUES (4, 1.99, 'USD', 2);
    
INSERT INTO Product
    VALUES (5, 'Time Of The Season');
    
INSERT INTO Music
    VALUES (5, 0.99, 'USD', 1);
