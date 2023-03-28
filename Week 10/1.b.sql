BEGIN TRANSACTION;

CREATE TABLE accounts (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  credit INT,
  currency VARCHAR(3),
  bankName VARCHAR(50)
);

INSERT INTO accounts (id, name, credit, currency, bankName)
VALUES 
(1, 'Account 1', 1000, 'RUB', 'SberBank'),
(2, 'Account 2', 1000, 'RUB', 'Tinkoff'),
(3, 'Account 3', 1000, 'RUB', 'SberBank');
(4, 'Fee Account', 0, 'RUB', '');

SAVEPOINT T1;
UPDATE accounts SET credit = credit - 500 WHERE id = 1;
UPDATE accounts SET credit = credit + 500 WHERE id = 3;

SAVEPOINT T2;
UPDATE accounts SET credit = credit - 730 WHERE id = 2;
UPDATE accounts SET credit = credit + 700 WHERE id = 1;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;

SAVEPOINT T3;
UPDATE accounts SET credit = credit - 130 WHERE id = 2;
UPDATE accounts SET credit = credit + 100 WHERE id = 3;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;

SELECT * FROM accounts;

ROLLBACK TO SAVEPOINT T1;

SELECT * FROM accounts;

COMMIT;