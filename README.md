# Clinical Trial Data Management & Quality Control

## Overview
This project simulates the management and quality control of clinical trial data for a fictional multi-site clinical study using entirely synthetic patient data.

The goal is to demonstrate practical skills in clinical data validation, database management, discrepancy identification, and quality control.

## Tools
- Python
- Pandas
- SQL
- Excel

## Project Objectives
- Create and manage synthetic clinical trial datasets
- Design a relational clinical database
- Develop data validation and edit checks
- Identify missing, duplicate, inconsistent, and out-of-range data
- Generate data discrepancy queries
- Track data quality and completeness
- Simulate database closeout quality-control procedures

## Dataset
The simulated study includes:
- Subjects
- Study sites
- Study visits
- Laboratory results
- Adverse events
- Medications
- Treatment information

## Data Quality Checks
Examples include:
- Missing required data
- Duplicate subject records
- Out-of-range laboratory values
- Visits occurring before enrollment
- Missing scheduled visits
- Adverse event resolution dates occurring before onset dates
- Medication end dates occurring before start dates

## Project Structure
- `data/` - Synthetic clinical trial datasets
- `python/` - Python data validation and QC scripts
- `sql/` - Database schema and SQL edit checks
- `documentation/` - Data dictionary and project documentation
- `output/` - Data discrepancy and QC reports
