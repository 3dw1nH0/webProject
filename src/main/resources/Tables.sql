-- 2tables for user and user roles.
CREATE TABLE users (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE user_roles (
    user_role_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_role_id),
    FOREIGN KEY (username) REFERENCES users(username)
);

INSERT INTO users VALUES ('keith', 'keithpw');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_USER');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_ADMIN');

INSERT INTO users VALUES ('andrew', 'andrewpw');
INSERT INTO user_roles(username, role) VALUES ('andrew', 'ROLE_ADMIN');

INSERT INTO users VALUES ('maria', 'mariapw');
INSERT INTO user_roles(username, role) VALUES ('maria', 'ROLE_USER');

INSERT INTO users VALUES ('oliver', 'oliverpw');
INSERT INTO user_roles(username, role) VALUES ('oliver', 'ROLE_USER');

-- newTables for online bidding website
CREATE TABLE item (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    description VARCHAR(255) NOT NULL,
    expectedPrice DECIMAL(5,2) NOT NULL,
	Owner VARCHAR(50) NOT NULL,
	noOfbids VARCHAR(255) NOT NULL,
	photo BLOB,
	status VARCHAR(255),
	winner VARCHAR(255) default null,
    PRIMARY KEY (id),
	FOREIGN KEY (Owner) REFERENCES users(username)
);

CREATE TABLE bidUser (
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    itemID INTEGER NOT NULL,
    username VARCHAR(50) NOT NULL,
	price DECIMAL(5,2),
	PRIMARY KEY (id),
	FOREIGN KEY (itemID) REFERENCES item(id),
        FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE Guestbook (
	id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	itemID INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	message VARCHAR(200) default null,
	date TIMESTAMP,
	PRIMARY KEY (id),
	FOREIGN KEY (itemID) REFERENCES item(id),
	FOREIGN KEY (name) REFERENCES users(username)	
);

