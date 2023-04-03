createdb vet_clinic
CREATE TABLE animals (
  id INTEGER PRIMARY KEY,
  name TEXT,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR;

-----Day3------ Query multiple tables-------

CREATE TABLE owners (
  id int primary key GENERATED ALWAYS AS IDENTITY,
  full_name varchar(255),
  age int
);
CREATE TABLE species (
  id int primary key GENERATED ALWAYS AS IDENTITY,
  name varchar(255)
);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals
ADD species_id INT;
ALTER TABLE animals
ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE;
ALTER TABLE animals
ADD owner_id INT;
ALTER TABLE animals
ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners (id) ON DELETE CASCADE;

-----Day4------ add "join table" for visits-------
CREATE TABLE vets (
  id int primary key GENERATED ALWAYS AS IDENTITY,
  name varchar(255),
  age integer,
  date_of_graduation date
);
CREATE TABLE specializations(
  specializations_id SERIAL PRIMARY KEY,
  species_id INTEGER REFERENCES species(id),
  vets_id INTEGER REFERENCES vets(id)
);
CREATE TABLE visits(
  visit_id SERIAL PRIMARY KEY,
  animals_id INTEGER REFERENCES animals (id),
  vets_id INTEGER REFERENCES vets(id),
  date_of_visit DATE
);

--Week 2 day 1 --database performance audit--
CREATE INDEX animals_id_idx on visits (animals_id);

CREATE INDEX vets_id_idx ON visits (vets_id);

CREATE INDEX idx_owners_email ON owners (email);
