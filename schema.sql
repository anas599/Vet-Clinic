/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INTEGER PRIMARY KEY,
  name TEXT,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL
);
