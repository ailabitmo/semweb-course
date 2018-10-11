USE simple_library;
SET NAMES 'utf8';
CREATE TABLE libraries (
	library_id INT AUTO_INCREMENT,
	name VARCHAR(256) NOT NULL,
	address VARCHAR(256) NOT NULL,
	PRIMARY KEY(library_id)
) DEFAULT CHARSET=utf8;
CREATE TABLE readers (
	reader_id INT AUTO_INCREMENT,
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	patronymic VARCHAR(64),
	PRIMARY KEY(reader_id)
) DEFAULT CHARSET=utf8;
CREATE TABLE books (
	book_id INT AUTO_INCREMENT,
	library_id INT NOT NULL,
	reader_id INT DEFAULT NULL,
	title VARCHAR(128) NOT NULL,
	author VARCHAR(128) NOT NULL,
	year CHAR(4) NOT NULL,
	PRIMARY KEY (book_id),
	FOREIGN KEY (library_id)
		REFERENCES libraries(library_id)
		ON DELETE CASCADE,
	FOREIGN KEY (reader_id)
		REFERENCES readers(reader_id)
		ON DELETE CASCADE
) DEFAULT CHARSET=utf8;
CREATE TABLE reader_library (
	link_id INT AUTO_INCREMENT,
	reader_id INT NOT NULL,
	library_id INT NOT NULL,
	PRIMARY KEY (link_id),
	FOREIGN KEY (reader_id)
		REFERENCES readers(reader_id)
		ON DELETE CASCADE,
	FOREIGN KEY (library_id)
		REFERENCES libraries(library_id)
		ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

