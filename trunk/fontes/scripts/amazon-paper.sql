CREATE TABLE Publisher (
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    primary key(name)
);

CREATE TABLE Recorder (
    recname VARCHAR(100) NOT NULL,
    primary key(recname)
);

CREATE TABLE Book (
    title VARCHAR(100) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    currency VARCHAR(20) NOT NULL,    
    isbn VARCHAR(20) NULL,
    publisher VARCHAR(100) NULL,
    PRIMARY KEY(title),
    CONSTRAINT FK_PUBL FOREIGN KEY(publisher) REFERENCES Publisher(name)
);

CREATE TABLE Music (
    title VARCHAR(100) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    currency VARCHAR(20) NOT NULL,    
    rec VARCHAR(100) NOT NULL,
    PRIMARY KEY(title),
    CONSTRAINT FK_REC FOREIGN KEY(rec) REFERENCES Recorder(recname)
);

CREATE VIEW s_product AS 
(select title AS s_title
from book)
union
(select title AS s_title
from music);

CREATE VIEW s_book AS 
select
    title AS s_title,
    publisher AS s_pub
from book;

CREATE VIEW s_music AS 
SELECT title AS s_title, 
   (SELECT r.recname 
    FROM recorder r
    WHERE r.recname = m.rec) AS s_recorder 
FROM music m

CREATE VIEW s_publ AS 
SELECT name AS s_name, address AS s_address
FROM publisher

INSERT INTO Publisher
    VALUES ('Manning Publications Co.', '20 Baldwin Road PO Box 261 Shelter Island, NY 11964');
        
INSERT INTO Book
    VALUES ('Android in Action', 49.99, 'USD', '9781935182726', 'Manning Publications Co.');
        
INSERT INTO Book
    VALUES ('Hello! Python', 34.99, 'USD', '9781935182085', 'Manning Publications Co.');
    
INSERT INTO Recorder
    VALUES ('Sony Music Entertainment');

INSERT INTO Music
    VALUES ('One In A Million', 1.99, 'USD', 'Sony Music Entertainment');
    
INSERT INTO Music
    VALUES ('Time Of The Season', 0.99, 'USD', 'Sony Music Entertainment');
