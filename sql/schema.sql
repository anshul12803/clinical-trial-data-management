-- Clinical Trial Data Management Project
-- Relational database schema for synthetic clinical trial data

CREATE TABLE subjects (
    subject_id TEXT PRIMARY KEY,
    site_id TEXT NOT NULL,
    age INTEGER,
    sex TEXT,
    enrollment_date DATE,
    treatment_arm TEXT
);

CREATE TABLE visits (
    visit_id TEXT PRIMARY KEY,
    subject_id TEXT NOT NULL,
    visit_name TEXT,
    visit_date DATE,
    status TEXT,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

CREATE TABLE labs (
    lab_id TEXT PRIMARY KEY,
    subject_id TEXT NOT NULL,
    visit_name TEXT,
    test_name TEXT,
    result REAL,
    unit TEXT,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

CREATE TABLE adverse_events (
    ae_id TEXT PRIMARY KEY,
    subject_id TEXT NOT NULL,
    event_term TEXT,
    onset_date DATE,
    resolution_date DATE,
    severity TEXT,
    serious TEXT,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);
