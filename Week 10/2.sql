CREATE TABLE accounts (
  username VARCHAR(50),
  fullname VARCHAR(50),
  balance INT,
  group_id INT
);

INSERT INTO accounts (username, fullname, balance, group_id)
VALUES 
('jones', 'Alice Jones', 82, 1),
('bitdiddl', 'Ben Bitdiddle', 65, 1),
('mike', 'Michael Dole', 73, 2),
('alyssa', 'Alyssa P. Hacker', 79, 3),
('bbrown', 'Bob Brown', 100, 3);