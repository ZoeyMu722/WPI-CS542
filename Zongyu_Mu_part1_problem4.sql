
DROP TABLE Perform CASCADE CONSTRAINTS;
DROP TABLE Plays CASCADE CONSTRAINTS;
DROP TABLE Lives CASCADE CONSTRAINTS;
DROP TABLE SongsAppears CASCADE CONSTRAINTS;
DROP TABLE AlbumProducer CASCADE CONSTRAINTS;
DROP TABLE Musicians CASCADE CONSTRAINTS;
DROP TABLE Instruments CASCADE CONSTRAINTS;
DROP TABLE Place CASCADE CONSTRAINTS;


CREATE TABLE Musicians (
    ssn CHAR(9) PRIMARY KEY,
    name VARCHAR2(50),
    annualIncome NUMBER
);

CREATE TABLE Instruments (
    instrID VARCHAR2(20) PRIMARY KEY,
    iname VARCHAR2(50),
    musickey VARCHAR2(10)
);

CREATE TABLE Place (
    aid VARCHAR2(20) PRIMARY KEY,
    address VARCHAR2(100),
    otherInfo VARCHAR2(100)
);


CREATE TABLE AlbumProducer (
    albumIdentifier VARCHAR2(20) PRIMARY KEY,
    ssn CHAR(9),
    copyrightDate DATE,
    speed NUMBER,
    title VARCHAR2(100),
    FOREIGN KEY (ssn) REFERENCES Musicians(ssn)
);

CREATE TABLE Plays (
    ssn CHAR(9),
    instrID VARCHAR2(20),
    PRIMARY KEY (ssn, instrID),
    FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
    FOREIGN KEY (instrID) REFERENCES Instruments(instrID)
);

CREATE TABLE Lives (
    ssn CHAR(9),
    aid VARCHAR2(20),
    phone VARCHAR2(20),
    PRIMARY KEY (ssn, aid),
    FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
    FOREIGN KEY (aid) REFERENCES Place(aid)
);


CREATE TABLE SongsAppears (
    songID VARCHAR2(20) PRIMARY KEY,
    authorSSN CHAR(9),
    title VARCHAR2(100),
    albumIdentifier VARCHAR2(20),
    FOREIGN KEY (authorSSN) REFERENCES Musicians(ssn),
    FOREIGN KEY (albumIdentifier) REFERENCES AlbumProducer(albumIdentifier)
);


CREATE TABLE Perform (
    ssn CHAR(9),
    songID VARCHAR2(20),
    PRIMARY KEY (songID, ssn),
    FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
    FOREIGN KEY (songID) REFERENCES SongsAppears(songID)
);


INSERT INTO Musicians VALUES ('111111111','Ben',60000);
INSERT INTO Musicians VALUES ('222222222','Alice',40000);
INSERT INTO Instruments VALUES ('I1','Saxophone','C');
INSERT INTO Instruments VALUES ('I2','Guitar','E');
INSERT INTO Place VALUES ('1','NYC','USA'); 
INSERT INTO Place VALUES ('2','Boston','USA');
INSERT INTO AlbumProducer VALUES ('A1','111111111',DATE '2022-01-01',33,'Blue Sky');
INSERT INTO AlbumProducer VALUES ('A2','111111111',DATE '2023-01-01',45,'Red Moon');
INSERT INTO SongsAppears VALUES ('S1','111111111','Dream','A1');
INSERT INTO SongsAppears VALUES ('S2','222222222','Light','A2');
INSERT INTO Plays VALUES ('111111111','I1');
INSERT INTO Plays VALUES ('222222222','I2');
INSERT INTO Lives VALUES ('111111111','1','123456');
INSERT INTO Lives VALUES ('222222222','2','654321');
INSERT INTO Perform VALUES ('111111111', 'S1');
INSERT INTO Perform VALUES ('222222222', 'S2');

COMMIT;