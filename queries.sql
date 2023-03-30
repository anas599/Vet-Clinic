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


-----Day3------ Query multiple tables-------

SELECT name AS name_of_animal,
    full_name AS owner_full_name
FROM animals
    JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

SELECT animals.name AS pokemons_only
FROM animals
    JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT full_name AS owner_full_name,
    name AS name_of_animal
FROM owners
    LEFT JOIN animals ON animals.owner_id = owners.id;

    SELECT species.name AS name_of_species,
    COUNT(species_id) AS how_many_species
FROM species
    JOIN animals ON animals.species_id = species.id
GROUP BY species.name;

SELECT name AS all_Digimons,
    full_name AS owner_full_name
FROM animals
    JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Jennifer Orwell'
    AND name LIKE '%mon';

    SELECT name AS name_of_animal,
    full_name AS owner_full_name
FROM animals
    JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Dean Winchester'
    AND escape_attempts = 0;

    SELECT full_name AS owner_full_name,
    COUNT(owner_id) AS biggest_number_of_animals_owned
FROM animals
    JOIN owners ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY biggest_number_of_animals_owned DESC
LIMIT 1;

