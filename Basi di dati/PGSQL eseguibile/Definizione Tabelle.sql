CREATE TABLE R_User(
	email VARCHAR(64) NOT NULL PRIMARY KEY, 
	passW VARCHAR(64) NOT NULL,
	nickname VARCHAR(64),
	notes VARCHAR(1024)
);

CREATE TABLE Contact(
	contactID SERIAL NOT NULL PRIMARY KEY,
	contactName VARCHAR(32) NOT NULL,
	surname VARCHAR(32) NOT NULL,
	propic VARCHAR(1024) DEFAULT 'C:\Users\Velios\Desktop\Uni\cd\defaultpic',
	favorite BOOLEAN NOT NULL DEFAULT 'false',
	r_user VARCHAR(64) NOT NULL,
	CONSTRAINT FK_userContact FOREIGN KEY (r_user) REFERENCES R_User(email) ON DELETE CASCADE
);

CREATE TABLE R_Group(
	groupID SERIAL NOT NULL PRIMARY KEY,
	groupName VARCHAR(32) NOT NULL,
	creationDate DATE NOT NULL,
	description VARCHAR(64),
	r_user VARCHAR(64) NOT NULL,
	CONSTRAINT FK_userGroup FOREIGN KEY (r_user) REFERENCES R_User(email) ON DELETE CASCADE
);

CREATE TABLE Participant(
	groupID INTEGER NOT NULL,
	contactID INTEGER NOT NULL,
	joinDate DATE NOT NULL,
	CONSTRAINT FK_groupIDParticipant FOREIGN KEY (groupID) REFERENCES R_Group(groupID) ON DELETE CASCADE,
	CONSTRAINT FK_contactIDParticipant FOREIGN KEY (contactID) REFERENCES Contact(contactID) ON DELETE CASCADE
);

CREATE TABLE Address(
	street VARCHAR(1024) NOT NULL, 
	zipCode CHAR(5) NOT NULL,
	city VARCHAR(32), 
	province CHAR(2), 
	country VARCHAR(32),
	CONSTRAINT PK_Address PRIMARY KEY (street, zipcode)
);

CREATE TABLE Email(
	email VARCHAR(1024) NOT NULL PRIMARY KEY,
	main BOOLEAN NOT NULL DEFAULT 'false',
	contactID INTEGER,
	CONSTRAINT FK_contactEmail FOREIGN KEY (contactID) REFERENCES Contact(contactID) ON DELETE SET NULL
);

CREATE TABLE Messaging(
	supplierName VARCHAR(64) NOT NULL,
	nickname VARCHAR(64) NOT NULL, 
	assEmail VARCHAR(1024) NOT NULL,
	status VARCHAR(1024),
	CONSTRAINT PK_Messaging PRIMARY KEY (supplierName, assEmail),
	CONSTRAINT FK_AssEmail FOREIGN KEY (assEmail) REFERENCES Email(email) ON DELETE CASCADE
);

CREATE TABLE PhoneNumber(
	phoneType VARCHAR(8) NOT NULL,
	phoneNumber CHAR(10) NOT NULL PRIMARY KEY,
	linkedNumber BOOLEAN NOT NULL DEFAULT 'false'
);

CREATE TABLE PhoneCall(
	callID SERIAL NOT NULL PRIMARY KEY,
	callType VARCHAR(32) NOT NULL,
	dateH TIMESTAMP NOT NULL,
	phoneNumber CHAR(10) NOT NULL,
	duration INTERVAL,
	contactName VARCHAR(64) DEFAULT 'UNKNOWN',
	r_user VARCHAR(64) NOT NULL,
	CONSTRAINT FK_userCall FOREIGN KEY (r_user) REFERENCES R_User(email) ON DELETE CASCADE
);

CREATE TABLE AssignedAddress(
	contactID INTEGER NOT NULL,
	addressStr VARCHAR(126) NOT NULL,
	addressZip VARCHAR(5) NOT NULL,
	main BOOLEAN DEFAULT 'false',
	CONSTRAINT FK_ADContactID FOREIGN KEY (contactID) REFERENCES Contact(contactID) ON DELETE CASCADE,
	CONSTRAINT FK_ADAddress FOREIGN KEY (addressStr, addressZip) REFERENCES Address(street, zipCode) ON DELETE CASCADE
);

CREATE TABLE AssignedPhone(
	phoneNumber CHAR(10) NOT NULL,
	contactID INTEGER,
	CONSTRAINT FK_APContactID FOREIGN KEY (ContactId) REFERENCES Contact(contactID) ON DELETE SET NULL,
	CONSTRAINT FK_phoneNumber FOREIGN KEY(phoneNumber) REFERENCES PhoneNumber(phoneNumber) ON DELETE CASCADE
);
