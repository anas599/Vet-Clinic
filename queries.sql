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

-----Day4------ add "join table" for visits-------

SELECT animals.name AS "last seen by William Tatcher"
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT COUNT(animals.name) AS "How many different animals did Stephanie Mendez see"
FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name AS vet_name, species.name AS specialties
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vets_id
LEFT JOIN species
ON species.id = specializations.species_id
ORDER BY vet_name;

SELECT animals.name AS animals, vets.name AS vet_name
FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez' 
AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name AS animals, COUNT(visits.animals_id) AS Highest_number_of_visits_to_vet
FROM animals
JOIN visits
ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY Highest_number_of_visits_to_vet DESC
LIMIT 1;

SELECT animals.name AS Maisy_Smith_first_visit
FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit ASC
LIMIT 1;

SELECT animals.name AS animal_name, vets.name AS vet_name, date_of_visit
FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT COUNT(visits.animals_id) AS "8. How many visits were with a vet that did not specialize"
FROM visits
LEFT JOIN specializations
ON visits.vets_id = specializations.vets_id
GROUP BY specializations.vets_id
HAVING specializations.vets_id IS NULL;

SELECT species.name AS "9. What specialty should Maisy Smith consider getting? Look for the species she gets the most."
FROM animals
JOIN species
ON animals.species_id = species.id
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.id
ORDER BY COUNT(species.id) DESC
LIMIT 1;

  --Week 2 day 1 --database performance audit--

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
