import pandas as pd

# Load synthetic clinical trial datasets
subjects = pd.read_csv("data/subjects.csv")
visits = pd.read_csv("data/visits.csv")
labs = pd.read_csv("data/labs.csv")
adverse_events = pd.read_csv("data/adverse_events.csv")

issues = []

# -----------------------------
# SUBJECT CHECKS
# -----------------------------

# Invalid age
for _, row in subjects[
    (subjects["age"] < 18) | (subjects["age"] > 90)
].iterrows():
    issues.append({
        "subject_id": row["subject_id"],
        "dataset": "subjects",
        "issue": "Age outside expected range (18-90)"
    })

# Invalid treatment arm
for _, row in subjects[
    ~subjects["treatment_arm"].isin(["A", "B"])
].iterrows():
    issues.append({
        "subject_id": row["subject_id"],
        "dataset": "subjects",
        "issue": "Invalid treatment arm"
    })

# -----------------------------
# VISIT CHECKS
# -----------------------------

visits["visit_date"] = pd.to_datetime(visits["visit_date"])
subjects["enrollment_date"] = pd.to_datetime(
    subjects["enrollment_date"]
)

visit_check = visits.merge(
    subjects[["subject_id", "enrollment_date"]],
    on="subject_id",
    how="left"
)

# Visit before enrollment
for _, row in visit_check[
    visit_check["visit_date"] < visit_check["enrollment_date"]
].iterrows():
    issues.append({
        "subject_id": row["subject_id"],
        "dataset": "visits",
        "issue": f"{row['visit_name']} visit occurred before enrollment"
    })

# Missing Week 8 visit
week8_subjects = set(
    visits.loc[
        visits["visit_name"] == "Week 8",
        "subject_id"
    ]
)

for subject_id in subjects["subject_id"]:
    if subject_id not in week8_subjects:
        issues.append({
            "subject_id": subject_id,
            "dataset": "visits",
            "issue": "Missing required Week 8 visit"
        })

# -----------------------------
# LAB CHECKS
# -----------------------------

# Missing lab results
for _, row in labs[labs["result"].isna()].iterrows():
    issues.append({
        "subject_id": row["subject_id"],
        "dataset": "labs",
        "issue": f"Missing {row['test_name']} result"
    })

# Hemoglobin range check
for _, row in labs[
    (labs["test_name"] == "Hemoglobin")
    & ((labs["result"] < 40) | (labs["result"] > 220))
].iterrows():
    issues.append({
        "subject_id": row["subject_id"],
        "dataset": "labs",
        "issue": "Hemoglobin outside expected range"
    })

# WBC range check
for _, row in labs[
    (labs["test_name"] == "WBC")
    & ((labs["result"] < 1) | (labs["result"] > 50))
].iterrows():
    issues.append({
        "subject_id": row["subject_id"],
        "dataset": "labs",
        "issue": "WBC outside expected range"
    })

# -----------------------------
# ADVERSE EVENT CHECKS
# -----------------------------

adverse_events["onset_date"] = pd.to_datetime(
    adverse_events["onset_date"]
)

adverse_events["resolution_date"] = pd.to_datetime(
    adverse_events["resolution_date"]
)

# Resolution date before onset date
for _, row in adverse_events[
    adverse_events["resolution_date"]
    < adverse_events["onset_date"]
].iterrows():
    issues.append({
        "subject_id": row["subject_id"],
        "dataset": "adverse_events",
        "issue": "Adverse event resolution date precedes onset date"
    })

# Invalid severity
valid_severity = ["Mild", "Moderate", "Severe"]

for _, row in adverse_events[
    ~adverse_events["severity"].isin(valid_severity)
].iterrows():
    issues.append({
        "subject_id": row["subject_id"],
        "dataset": "adverse_events",
        "issue": "Missing or invalid adverse event severity"
    })

# -----------------------------
# CREATE DISCREPANCY REPORT
# -----------------------------

issues_df = pd.DataFrame(issues)

if issues_df.empty:
    print("QC complete: No data discrepancies detected.")
else:
    issues_df.to_csv(
        "output/data_queries.csv",
        index=False
    )

    print(f"QC complete: {len(issues_df)} discrepancies detected.")
    print(issues_df)
