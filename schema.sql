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