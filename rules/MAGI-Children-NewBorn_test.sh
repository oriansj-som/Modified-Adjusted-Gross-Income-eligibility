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
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (51, 0, 193);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (15, 51);
--our second case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (52, 5, 194);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (16, 52);
-- Final wrap
.quit
EOF

# Run with required case info
./rules/MAGI-Children-NewBorn.py 15 51
./rules/MAGI-Children-NewBorn.py 16 52



# Get results to prove success

{
sqlite3 core.db <<-EOF
.separator "\t"
SELECT CaseID,  Result, flag FROM Case_Determinations;
.quit
EOF
} #>| rules/results/MAGI-Children-NewBorn_test-result

exit 0
