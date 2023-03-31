INSERT INTO animals(id, name, escape_attempts, neutered, weight_kg, date_of_birth) 
VALUES (4, 'Devimon', 5, TRUE, 11, TO_DATE('May 12th, 2017', 'Mon DDth, YYYY'));

INSERT INTO animals(id, name, escape_attempts, neutered, weight_kg, date_of_birth) 
VALUES (3, 'Pikachu', 1, FALSE, 15.04, TO_DATE('Jan 7th, 2021', 'Mon DDth, YYYY'));

INSERT INTO animals(id, name, escape_attempts, neutered, weight_kg, date_of_birth) 
VALUES (2, 'Gabumon', 2, TRUE, 8, TO_DATE('Nov 15th, 2018', 'Mon DDth, YYYY'));

INSERT INTO animals(id, name,escape_attempts, neutered, weight_kg, date_of_birth)
VALUES (1, 'Agumon', 0, TRUE, 10.23,TO_DATE('Feb 3rd, 2020', 'Mon DDth, YYYY'));

INSERT INTO animals(species, id, name,escape_attempts, neutered, weight_kg, date_of_birth)
VALUES ('Animal', 5, 'Charmander', 0, FALSE, -11,TO_DATE('Feb 8th, 2020', 'Mon DDth, YYYY'));

INSERT INTO animals(species, id, name,escape_attempts, neutered, weight_kg, date_of_birth)
VALUES ('Animal', 6, 'Plantmon', 2, TRUE, -5.7,TO_DATE('Nov 15th, 2021', 'Mon DDth, YYYY'));

INSERT INTO animals(species, id, name,escape_attempts, neutered, weight_kg, date_of_birth)
VALUES ('Animal', 7, 'Squirtle', 3, FALSE, -12.13 ,TO_DATE('Apr 2nd, 1993', 'Mon DDth, YYYY'));

INSERT INTO animals(species, id, name,escape_attempts, neutered, weight_kg, date_of_birth)
VALUES ('Animal', 8, 'Angemon', 1, TRUE, -45 ,TO_DATE('Jun 12th, 2005', 'Mon DDth, YYYY'));

INSERT INTO animals(species, id, name,escape_attempts, neutered, weight_kg, date_of_birth)
VALUES ('Animal', 9, 'Boarmon', 7, TRUE, 20.4 ,TO_DATE('Jun 7th, 2005', 'Mon DDth, YYYY'));

INSERT INTO animals(species, id, name,escape_attempts, neutered, weight_kg, date_of_birth)
VALUES ('Animal', 10, 'Blossom', 3, TRUE, 17 ,TO_DATE('Oct 13th, 1998', 'Mon DDth, YYYY'));

INSERT INTO animals(species, id, name,escape_attempts, neutered, weight_kg, date_of_birth)
VALUES ('Animal', 11, 'Ditto', 4, TRUE, 22 ,TO_DATE('May 14th, 2022', 'Mon DDth, YYYY'));

----Day3-------- Query multiple tables-----------

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);
INSERT INTO species (name)
VALUES ('Pokemon'),
  ('Digimon');
UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN (
      SELECT id
      FROM species
      WHERE name = 'Digimon'
    )
    ELSE (
      SELECT id
      FROM species
      WHERE name = 'Pokemon'
    )
  END;

  UPDATE animals
SET owner_id = owners.id
FROM owners
WHERE 
    (animals.name = 'Agumon' AND owners.full_name = 'Sam Smith') OR
    (animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell') OR
    (animals.name IN ('Devimon', 'Plantmon') AND owners.full_name = 'Bob') OR
    (animals.name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond') OR
    (animals.name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester')

-----Day4------ add "join table" for visits-------

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');
  
INSERT INTO specializations (species_id, vets_id)
VALUES (
    (
      SELECT id
      FROM species
      WHERE name = 'Pokemon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'William Tatcher'
    )
  ),
  (
    (
      SELECT id
      FROM species
      WHERE name = 'Digimon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Stephanie Mendez'
    )
  ),
  (
    (
      SELECT id
      FROM species
      WHERE name = 'Pokemon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Stephanie Mendez'
    )
  ),
  (
    (
      SELECT id
      FROM species
      WHERE name = 'Digimon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Jack Harkness'
    )
  );
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES (
    (
      SELECT id
      FROM animals
      WHERE name = 'Agumon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'William Tatcher'
    ),
    '2020-05-24'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Agumon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Stephanie Mendez'
    ),
    '2020-07-22'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Gabumon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Jack Harkness'
    ),
    '2021-02-02'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Pikachu'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2020-01-05'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Pikachu'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2020-03-08'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Pikachu'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2020-05-14'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Devimon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Stephanie Mendez'
    ),
    '2021-05-04'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Charmander'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Jack Harkness'
    ),
    '2021-02-24'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Plantmon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2019-12-21'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Plantmon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'William Tatcher'
    ),
    '2020-08-10'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Plantmon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2021-04-07'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Squirtle'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Stephanie Mendez'
    ),
    '2019-09-29'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Angemon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Jack Harkness'
    ),
    '2020-10-03'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Angemon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Jack Harkness'
    ),
    '2020-11-04'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Boarmon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2019-01-24'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Boarmon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2019-05-15'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Boarmon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2020-02-27'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Boarmon'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Maisy Smith'
    ),
    '2020-08-03'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Blossom'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'Stephanie Mendez'
    ),
    '2020-05-24'
  ),
  (
    (
      SELECT id
      FROM animals
      WHERE name = 'Blossom'
    ),
    (
      SELECT id
      FROM vets
      WHERE name = 'William Tatcher'
    ),
    '2021-01-11'
  );