#!/usr/bin/env bash
set -eux

# Initialize table to test values
sqlite3 core.db <<-EOF
-- Clearing and reseting tables for test
DROP TABLE IF EXISTS CaseID;
DROP TABLE IF EXISTS Case_Determinations;

CREATE TABLE 'CaseID' ( 'CaseID' INTEGER, 'Age','FPL'  INTEGER, 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker');
CREATE TABLE 'Case_Determinations' ( auto INTEGER, 'CaseID' INTEGER,  'Result'  INTEGER, 'Flag' TEXT);
--our first case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (41, 41, 108);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (6, 41);
--our second case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (54, 19, 132);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (10, 54);
--our third case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (55, 17, 135);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (11, 55);
--our fourth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (57, 22, 140);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (13, 57);
-- Final wrap
.quit
EOF

# Run with required case info
./rules/MAGI-Children-HKE.py 6 41
./rules/MAGI-Children-HKE.py 10 54
./rules/MAGI-Children-HKE.py 11 55
./rules/MAGI-Children-HKE.py 13 57
# Get results to prove success

{
sqlite3 core.db <<-EOF
.separator "\t"
SELECT CaseID,  Result, flag FROM Case_Determinations;
.quit
EOF
} # >| rules/results/MAGI-Children-HKE-result

exit 0
