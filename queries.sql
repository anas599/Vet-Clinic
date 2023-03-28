SELECT * FROM animals WHERE name like '%mon'
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01'
AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE
AND escape_attempts > 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon'
OR name = 'Pikachu';
SELECT name FROM animals WHERE weight_kg < 10.5;
SELECT name FROM animals WHERE neutered = TRUE;
SELECT name FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species NOT LIKE '%mon';

COMMIT;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;

SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals
WHERE date_of_birth >= '2022-01-01';
SAVEPOINT save_del;
UPDATE animals
SET weight_kg = weight_kg*-1;
ROLLBACK TO SAVEPOINT save_del;
UPDATE animals 
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals
WHERE date_of_birth >= '2022-01-01';
SAVEPOINT save_del;
UPDATE animals
SET weight_kg = weight_kg*-1;
ROLLBACK TO SAVEPOINT save_del;
UPDATE animals 
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0

SELECT AVG(weight_kg) FROM animals

SELECT neutered, MAX(escape_attempts)
FROM animals
WHERE escape_attempts = (
  SELECT MAX(escape_attempts) 
  FROM animals
)
GROUP BY neutered;

SELECT MIN(weight_kg), MAX(weight_kg) FROM animals
WHERE species LIKE 'digimon'
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals
WHERE species LIKE 'pokemon'

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;
