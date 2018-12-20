#!/usr/bin/env bash
set -eux

# Initialize table to test values
sqlite3 core.db <<-EOF
-- Clearing and reseting tables for test 
DROP TABLE IF EXISTS CaseID;
DROP TABLE IF EXISTS Case_Determinations;

CREATE TABLE 'CaseID' ( 'CaseID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'Age' INTEGER NOT NULL, 'FPL' INTEGER NOT NULL, 'Gender' TEXT NOT NULL, 'Pregnant' INTEGER NOT NULL, 'ComprehensiveInsurance' INTEGER NOT NULL, 'Caretaker' INTEGER NOT NULL );
CREATE TABLE 'Case_Determinations' ( 'auto' INTEGER PRIMARY KEY AUTOINCREMENT, 'CaseID' INTEGER NOT NULL, 'Result' INTEGER, 'Datetime' INTEGER, 'async' INTEGER, 'Flag' TEXT );

-- Our first case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (42, 64.0, 22, 'Female', 0, 0, 0);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (2, 2);
-- Our second case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (40, 4.7, 300, 'Male', 0, 0, 1);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (3, 40);
-- Our third case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (50, 54.5, 95, 'Female', 0, 0, 1);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (1, 41);
-- Our fourth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (51, 21.7, 87, 'Male', 0, 0, 1);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (5, 42);
-- Our fifth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (20, 30.7, 30, 'Male', 0, 0, 1);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (6, 44);
-- Our sixth case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (00, 0.0, 00, 'Female', 0, 0, 1);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (7, 45);
--Our seventh 
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (44, 4.4, 244, 'Male', 0, 0, 1);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (9, 35);
-- Final wrap 
.quit
EOF


# Run with required case info
./rules/MAGI-Children-HK1.py 2 42
./rules/MAGI-Children-HK1.py 3 40
./rules/MAGI-Children-HK1.py 1 50
./rules/MAGI-Children-HK1.py 5 51
./rules/MAGI-Children-HK1.py 6 20
./rules/MAGI-Children-HK1.py 7 00
./rules/MAGI-Children-HK1.py 9 44

# Get results to prove success
{
sqlite3 core.db <<-EOF
.separator "\t"
SELECT CaseID,  Result, Flag FROM Case_Determinations;
.quit
EOF
} >| rules/results/MAGI-Children-HK1-result

exit 0
