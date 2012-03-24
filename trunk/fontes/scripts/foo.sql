CREATE TABLE Addresses (
    ID INT, 
    city CHAR(10), 
    state CHAR(2), 
    PRIMARY KEY(ID)
);

CREATE TABLE Department (
    ID INT, 
    name CHAR(10), 
    city CHAR(10), 
    manager INT, 
    PRIMARY KEY(name, city)
);

CREATE TABLE People (
    ID INT, 
    fname CHAR(10), 
    addr INT, 
    deptName CHAR(10), 
    deptCity CHAR(10), 
    PRIMARY KEY(ID), 
    FOREIGN KEY(addr) REFERENCES Addresses(ID), 
    FOREIGN KEY(deptName, deptCity) REFERENCES Department(name, city) 
);

ALTER TABLE Department ADD FOREIGN KEY(manager) REFERENCES People(ID);

