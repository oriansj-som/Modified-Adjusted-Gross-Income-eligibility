#!/usr/bin/env bash
set -eux

# Initialize table to test values
sqlite3 core.db <<-EOF
-- Clearing and reseting tables for test
DROP TABLE IF EXISTS CaseID;
DROP TABLE IF EXISTS Case_Determinations;

CREATE TABLE 'CaseID' ('CaseID' INTEGER, 'Age','FPL'  INTEGER, 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker'); 
CREATE TABLE 'Case_Determinations' ( auto INTEGER, 'CaseID' INTEGER,  'Result'  INTEGER, 'Flag' TEXT);
--our first case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (41, 18, 194);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (5, 41);
--our second case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (42, 20, 193);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (6, 42);
--our third case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (43, 16, 196);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (7, 43);
--our fourth case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (44, 21, 197);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (8, 44);
-- Final wrap
.quit
EOF

# Run with required case info
./rules/MAGI-Children-Main.py 5 41
./rules/MAGI-Children-Main.py 6 42
./rules/MAGI-Children-Main.py 7 43
./rules/MAGI-Children-Main.py 8 44



# Get results to prove

{
sqlite3 core.db <<-EOF
.separator "\t"
SELECT CaseID,  Result, flag FROM Case_Determinations;
.quit
EOF
} >| rules/results/MAGI-Children-Main-result

exit 0
