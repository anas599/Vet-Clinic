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