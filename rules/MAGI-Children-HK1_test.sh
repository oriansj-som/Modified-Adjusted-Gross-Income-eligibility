#!/usr/bin/env bash
set -eux

# Initialize table to test values
sqlite3 core.db <<-EOF
DROP TABLE IF EXISTS CaseID;
DROP TABLE IF EXISTS Case_Determinations;
DROP TABLE IF EXISTS Determinations;
CREATE TABLE 'CaseID' ( 'CaseID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'Age' INTEGER NOT NULL, 'FPL' INTEGER NOT NULL, 'Gender' TEXT NOT NULL, 'Pregnant' INTEGER NOT NULL, 'ComprehensiveInsurance' INTEGER NOT NULL, 'Caretaker' INTEGER NOT NULL );
CREATE TABLE 'Case_Determinations' ( 'auto' INTEGER PRIMARY KEY AUTOINCREMENT, 'CaseID' INTEGER NOT NULL, 'DeterminationID' INTEGER NOT NULL, 'Result' INTEGER, 'Datetime' INTEGER, 'async' INTEGER, 'Flag' TEXT );
CREATE TABLE 'Determinations' ( 'DeterminationID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 'executable' TEXT NOT NULL, 'Active' INTEGER NOT NULL, 'DeterminationText' TEXT NOT NULL );
-- Our first case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (42, 64.0, 22, 'Female', 0, 0, 0);
INSERT INTO Case_Determinations ( 'auto', 'CaseID', 'DeterminationID' ) VALUES (2, 2, 12);
-- Our second case
INSERT INTO CaseID ( 'CaseID', 'Age', 'FPL', 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker') VALUES (40, 4.7, 300, 'Male', 0, 0, 1);
INSERT INTO Case_Determinations ( 'auto', 'CaseID', 'DeterminationID' ) VALUES (3, 40, 12);
INSERT INTO Determinations ( 'DeterminationID', 'executable', 'Active', 'DeterminationText' ) VALUES (12, "rules/MAGI-Children-HK1.py", 1, "MAGI-Children-HK1");
.quit
EOF


# Run with required case info
./rules/MAGI-Children-HK1.py 2 42
./rules/MAGI-Children-HK1.py 3 40

# Get results to prove success
{
sqlite3 core.db <<-EOF
.separator "\t"
SELECT CaseID, DeterminationID, Result, Datetime, async, Flag FROM Case_Determinations;
.quit
EOF
} >| rules/results/MAGI-Children-HK1-result

exit 0
