createdb digram_db

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INTEGER ,
  medical_history_id INTEGER ,
  status TEXT
);

CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE,
  contact_info VARCHAR(255)
);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255),
  name VARCHAR(255),
  medical_history_id INTEGER REFERENCES medical_histories(id)
);
CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL(10,2),
  quantity INTEGER,
  total_price DECIMAL(10,2),
  invoice_id INTEGER REFERENCES invoices(id),
  treatment_id INTEGER REFERENCES treatments(id)
);

ALTER TABLE medical_histories
ADD CONSTRAINT fk_patient_id
FOREIGN KEY (patient_id)
REFERENCES patients(id);

ALTER TABLE medical_histories
ADD CONSTRAINT fk_medical_history_id
FOREIGN KEY (medical_history_id)
REFERENCES medical_histories(id);