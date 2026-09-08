-- Clinical Trial Data Quality Edit Checks
-- Synthetic educational portfolio project

-- 1. Subjects with invalid age
SELECT *
FROM subjects
WHERE age < 18 OR age > 90;

-- 2. Missing treatment arm
SELECT *
FROM subjects
WHERE treatment_arm IS NULL
   OR treatment_arm = '';

-- 3. Invalid treatment arm values
SELECT *
FROM subjects
WHERE treatment_arm NOT IN ('A', 'B');

-- 4. Visits occurring before enrollment
SELECT
    v.subject_id,
    v.visit_name,
    v.visit_date,
    s.enrollment_date
FROM visits v
JOIN subjects s
    ON v.subject_id = s.subject_id
WHERE v.visit_date < s.enrollment_date;

-- 5. Duplicate visit records
SELECT
    subject_id,
    visit_name,
    COUNT(*) AS record_count
FROM visits
GROUP BY subject_id, visit_name
HAVING COUNT(*) > 1;

-- 6. Missing required Week 4 visits
SELECT s.subject_id
FROM subjects s
LEFT JOIN visits v
    ON s.subject_id = v.subject_id
    AND v.visit_name = 'Week 4'
WHERE v.visit_id IS NULL;

-- 7. Missing required Week 8 visits
SELECT s.subject_id
FROM subjects s
LEFT JOIN visits v
    ON s.subject_id = v.subject_id
    AND v.visit_name = 'Week 8'
WHERE v.visit_id IS NULL;

-- 8. Missing laboratory results
SELECT *
FROM labs
WHERE result IS NULL;

-- 9. Implausible hemoglobin values
SELECT *
FROM labs
WHERE test_name = 'Hemoglobin'
  AND (result < 40 OR result > 220);

-- 10. Implausible WBC values
SELECT *
FROM labs
WHERE test_name = 'WBC'
  AND (result < 1 OR result > 50);

-- 11. Unexpected hemoglobin units
SELECT *
FROM labs
WHERE test_name = 'Hemoglobin'
  AND unit <> 'g/L';

-- 12. Unexpected WBC units
SELECT *
FROM labs
WHERE test_name = 'WBC'
  AND unit <> '10^9/L';

-- 13. Adverse event resolution before onset
SELECT *
FROM adverse_events
WHERE resolution_date < onset_date;

-- 14. Missing adverse event severity
SELECT *
FROM adverse_events
WHERE severity IS NULL
   OR severity = '';

-- 15. Invalid adverse event severity
SELECT *
FROM adverse_events
WHERE severity NOT IN ('Mild', 'Moderate', 'Severe');

-- 16. Invalid serious adverse event value
SELECT *
FROM adverse_events
WHERE serious NOT IN ('Y', 'N');

-- 17. Adverse event linked to unknown subject
SELECT ae.*
FROM adverse_events ae
LEFT JOIN subjects s
    ON ae.subject_id = s.subject_id
WHERE s.subject_id IS NULL;

-- 18. Lab record linked to unknown subject
SELECT l.*
FROM labs l
LEFT JOIN subjects s
    ON l.subject_id = s.subject_id
WHERE s.subject_id IS NULL;

-- 19. Visit linked to unknown subject
SELECT v.*
FROM visits v
LEFT JOIN subjects s
    ON v.subject_id = s.subject_id
WHERE s.subject_id IS NULL;

-- 20. Missing subject identifier
SELECT *
FROM subjects
WHERE subject_id IS NULL
   OR subject_id = '';
