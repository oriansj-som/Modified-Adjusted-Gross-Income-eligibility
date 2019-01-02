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
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (51, 61, 108);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (7, 51);
--our third case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (52, 62, 107);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (8, 52);
--our fourth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (53, 63, 106);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (9, 53);
--our fifth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (54, 17.75, 132);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (10, 54);
--our sixth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (55, 17.5, 135);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (11, 55);
--our seventh case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (56, 18.5, 130);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (12, 56);
--our eighth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (57, 18, 140);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (13, 57);
--our nineth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (58, 68, 150);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (14, 58);
--our tenth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (59, 18, 100);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (15, 59);
--our eleventh case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL') VALUES (60, 17, 120);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (16, 60);
-- Final wrap
.quit
EOF


# Run with required case info
./rules/MAGI-Children-HKE.py 6 41
./rules/MAGI-Children-HKE.py 7 51
./rules/MAGI-Children-HKE.py 8 52
./rules/MAGI-Children-HKE.py 9 53
./rules/MAGI-Children-HKE.py 10 54
./rules/MAGI-Children-HKE.py 11 55
./rules/MAGI-Children-HKE.py 12 56
./rules/MAGI-Children-HKE.py 13 57
./rules/MAGI-Children-HKE.py 14 58
./rules/MAGI-Children-HKE.py 15 59
./rules/MAGI-Children-HKE.py 16 60
# Get results to prove

{
sqlite3 core.db <<-EOF
.separator "\t"
SELECT CaseID,  Result, flag FROM Case_Determinations;
.quit
EOF
} >| rules/results/MAGI-Children-HKE-result

exit 0
