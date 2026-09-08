# Clinical Trial Data Management & Quality Control

## Overview

This independent portfolio project simulates core clinical data management and quality-control workflows using entirely synthetic clinical trial data.

The project demonstrates how structured clinical datasets can be reviewed using SQL and Python to identify missing, inconsistent, illogical, and out-of-range data.

## Objectives

- Create structured synthetic clinical trial datasets
- Design a relational database schema
- Develop SQL-based edit checks
- Build a Python validation pipeline using Pandas
- Detect clinical data discrepancies
- Generate a structured data query report
- Demonstrate basic database quality-control and closeout concepts

## Tools

- Python
- Pandas
- SQL
- CSV
- GitHub

## Dataset Structure

The synthetic study includes:

- Subject demographics and enrollment
- Study visits
- Laboratory results
- Adverse events

All data in this repository are fictional and were created solely for educational purposes.

## Data Quality Checks

The project includes validation rules for:

- Missing required visits
- Invalid treatment assignments
- Out-of-range laboratory values
- Missing laboratory results
- Incorrect laboratory units
- Visits occurring at illogical time points
- Invalid adverse-event severity
- Adverse-event resolution dates occurring before onset dates
- Unknown subject identifiers
- Duplicate records

## Validation Pipeline

The Python validation script:

1. Loads the synthetic clinical datasets
2. Converts relevant fields to appropriate data types
3. Applies predefined data-quality rules
4. Identifies records that fail validation
5. Generates a structured discrepancy report

## Example QC Results

Three intentional data discrepancies were introduced to test the validation pipeline:

| Subject | Dataset | Detected Issue |
|---|---|---|
| SUB010 | Visits | Missing required Week 8 visit |
| SUB001 | Labs | Hemoglobin outside expected range |
| SUB003 | Adverse Events | Resolution date precedes onset date |

The validation pipeline successfully detected all three test discrepancies.

## Repository Structure

```text
clinical-trial-data-management/
├── data/
│   ├── subjects.csv
│   ├── visits.csv
│   ├── labs.csv
│   └── adverse_events.csv
├── python/
│   └── validate_data.py
├── sql/
│   ├── schema.sql
│   └── edit_checks.sql
├── output/
│   └── data_queries.csv
└── README.md
