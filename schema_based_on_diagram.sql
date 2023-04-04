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

CREATE TABLE medical_treatment(
  medical_histories_id INTEGER REFERENCES medical_histories (id),
  treatments_id INTEGER REFERENCES treatments(id),
);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INTEGER,
  total_price DECIMAL,
  invoice_id INTEGER REFERENCES invoices(id),
  treatment_id INTEGER REFERENCES treatments(id)
);

--Add index to each table--
CREATE INDEX idx_invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items (treatment_id);
CREATE INDEX idx_invoices_medical_history_id ON invoices (medical_history_id);
CREATE INDEX idx_medical_histories_patient_id ON medical_histories (patient_id);
CREATE INDEX idx_medical_histories_status ON medical_histories (status);
CREATE INDEX idx_patients_name ON patients (name);
CREATE INDEX idx_treatments_medical_history_id ON treatments (medical_history_id);
CREATE INDEX idx_treatments_type ON treatments (type);
CREATE INDEX idx_treatments_name ON treatments (name);
