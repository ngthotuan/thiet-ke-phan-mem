DROP DATABASE QuanLyThuVien;
CREATE DATABASE QuanLyThuVien;
USE QuanLyThuVien;

CREATE TABLE `FREQUENTLY_QUESTIONS` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `QUESTION` VARCHAR(255),
 `ANSWER` VARCHAR(255),
	PRIMARY KEY (`ID`)
);

CREATE TABLE `READING_ROOM` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `ROOMNAME` VARCHAR(255),
 PRIMARY KEY (`ID`)
);

CREATE TABLE `ROOM_BORROW` (
 `ID` INT NOT NULL,
 `ROOMID` INT NULL,
 `ACCOUNTID` INT NULL,
 `BORROWTIME` DATETIME NULL,
 `DUETIME` DATETIME NULL,
 PRIMARY KEY (`ID`)
);

CREATE TABLE `ACCOUNTS` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `USERID` INT DEFAULT NULL,
 `USERNAME` VARCHAR(255) DEFAULT NULL,
 `PASSWORD` VARCHAR(255) DEFAULT NULL,
 `STATUS` INT DEFAULT 1,
 PRIMARY KEY (`ID`)
);
-- `STATUS` ENUM('ACTIVE','BLOCK') DEFAULT 'ACTIVE',

CREATE TABLE `AUTHOR_BOOK` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `IDAUTHOR` INT,
 `IDBOOK` INT,
  PRIMARY KEY (`ID`)
);

CREATE TABLE `AUTHORS` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `NAME` VARCHAR(255) DEFAULT NULL,
 `DESCRIPTION` VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY (`ID`)
);

CREATE TABLE `BOOK_BORROW` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `BORROWTIME` DATETIME,
 `DUETIME` DATETIME,
 `BOOKITEMID` INT DEFAULT NULL,
 `ACCOUNTID` INT DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

CREATE TABLE `BOOK_ITEMS` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `BARCODE` VARCHAR(255) DEFAULT NULL,
 `STATUS` INT DEFAULT 1,
 `CANBORROW` TINYINT(1) DEFAULT NULL,
 `BOOKID` INT DEFAULT NULL,
 `SHELF` VARCHAR(255) DEFAULT NULL,
 `PUBLISHDATE` DATETIME DEFAULT NULL,
 PRIMARY KEY (`ID`)
) ;
-- `STATUS` ENUM('AVAILABLE','NOTAVAILABLE') DEFAULT 'AVAILABLE',

CREATE TABLE `BOOK_RESERVATIONS` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 BOOKITEMID INT,
 `USERID` INT DEFAULT NULL,
 `TIME` DATETIME DEFAULT NULL,
 PRIMARY KEY (`ID`)
);

CREATE TABLE `BOOKS` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `TITLE` VARCHAR(255) DEFAULT NULL,
 `PUBLISHERID` INT DEFAULT NULL,
 `ISBN` VARCHAR(255) DEFAULT NULL,
 `CATEGORYID` INT DEFAULT NULL,
 `FINE` DOUBLE DEFAULT NULL,
 PRIMARY KEY (`ID`)
);

CREATE TABLE `CARDS` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `BARCODE` VARCHAR(255) DEFAULT NULL,
 `READERID` INT DEFAULT NULL,
 PRIMARY KEY (`ID`)
);

CREATE TABLE `CATEGORIES` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `NAME` VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY (`ID`) 
);

CREATE TABLE `FINES` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `CREATEDAT` DATETIME DEFAULT NULL,
 `BOOKBORROWID` INT DEFAULT NULL,
 `AMOUNT` DOUBLE DEFAULT NULL,
 PRIMARY KEY (`ID`)
); 

CREATE TABLE `PUBLISHERS` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `NAME` VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY (`ID`)
);

CREATE TABLE `READER_TYPES` (
 `ID` INT NOT NULL AUTO_INCREMENT,
 `NAME` VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY (`ID`)
);

CREATE TABLE `READERS` (
 `PERSONID` INT NOT NULL AUTO_INCREMENT,
 `NAME` VARCHAR(255) DEFAULT NULL,
 `DOB` DATETIME DEFAULT NULL,
 `ADDRESS` VARCHAR(255) DEFAULT NULL,
 `EMAIL` VARCHAR(255) DEFAULT NULL,
 `PHONE` VARCHAR(255) DEFAULT NULL,
 `TYPE` INT DEFAULT NULL,
 PRIMARY KEY (`PERSONID`)
);

CREATE TABLE CONSTANTS(
 ID INT AUTO_INCREMENT PRIMARY KEY ,
 K VARCHAR(255),
 VAL VARCHAR(255)
);


CREATE TABLE USER_RESPONSES(
 ID INT AUTO_INCREMENT PRIMARY KEY ,
 ACCOUNTID INT,
 CONTENT VARCHAR(255) ,
 CREATETIME DATETIME
);
ALTER TABLE `ROOM_BORROW` ADD FOREIGN KEY (`ROOMID`) REFERENCES `READING_ROOM` (`ID`);
ALTER TABLE `ROOM_BORROW` ADD FOREIGN KEY (`ACCOUNTID`) REFERENCES `ACCOUNTS` (`ID`);
ALTER TABLE `ACCOUNTS` ADD FOREIGN KEY (`USERID`) REFERENCES `READERS` (`PERSONID`);
ALTER TABLE `AUTHOR_BOOK` ADD FOREIGN KEY (`IDAUTHOR`) REFERENCES `AUTHORS` (`ID`);
ALTER TABLE `AUTHOR_BOOK` ADD FOREIGN KEY (`IDBOOK`) REFERENCES `BOOKS` (`ID`);
ALTER TABLE `BOOK_BORROW` ADD FOREIGN KEY (`BOOKITEMID`) REFERENCES `BOOK_ITEMS` (`ID`);
ALTER TABLE `BOOK_BORROW` ADD FOREIGN KEY (`ACCOUNTID`) REFERENCES `ACCOUNTS` (`ID`);
ALTER TABLE `BOOK_ITEMS` ADD FOREIGN KEY (`BOOKID`) REFERENCES `BOOKS` (`ID`);
ALTER TABLE `BOOK_RESERVATIONS` ADD FOREIGN KEY (`USERID`) REFERENCES `ACCOUNTS` (`ID`);
ALTER TABLE `BOOKS` ADD FOREIGN KEY (`PUBLISHERID`) REFERENCES `PUBLISHERS` (`ID`);
ALTER TABLE `BOOKS` ADD FOREIGN KEY (`CATEGORYID`) REFERENCES `CATEGORIES` (`ID`);
ALTER TABLE `CARDS` ADD FOREIGN KEY (`READERID`) REFERENCES `READERS` (`PERSONID`);
ALTER TABLE `FINES` ADD FOREIGN KEY (`BOOKBORROWID`) REFERENCES `BOOK_BORROW` (`ID`);
ALTER TABLE `READERS` ADD FOREIGN KEY (`TYPE`) REFERENCES `READER_TYPES` (`ID`);
ALTER TABLE BOOK_RESERVATIONS ADD FOREIGN KEY (BOOKITEMID) REFERENCES BOOK_ITEMS(ID);
ALTER TABLE USER_RESPONSES ADD FOREIGN KEY (ACCOUNTID) REFERENCES ACCOUNTS(ID);
