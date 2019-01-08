#!/usr/bin/env bash
set -eux
# Initialize table to test values
sqlite3 core.db <<-EOF
-- Clearing and reseting tables for test
DROP TABLE IF EXISTS CaseID;
DROP TABLE IF EXISTS Case_Determinations;

CREATE TABLE 'CaseID' ('CaseID' INTEGER, 'Age','FPL'  INTEGER, 'Gender', 'Pregnant', 'ComprehensiveInsurance', 'Caretaker'); 
CREATE TABLE 'Case_Determinations' ( auto INTEGER, 'CaseID' INTEGER,  'Result'  INTEGER, 'Flag' TEXT);
-- Our first case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (51, 15, 55);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (15, 51);
--our second case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (52, 20,110);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (16, 52);
--our third case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (53, 15, 175);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (17, 53);
--our fourth case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (54, 9, 185);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (18, 54);
--our fifth case
INSERT INTO CaseID ('CaseID','Age', 'FPL') VALUES (55, 5, 15);
INSERT INTO Case_Determinations ( 'auto', 'CaseID') VALUES (19, 55);

-- Final wrap
.quit
EOF

# Run with required case info
./rules/MAGI-Children-OHK.py 15 51
./rules/MAGI-Children-OHK.py 16 52
./rules/MAGI-Children-OHK.py 17 53
./rules/MAGI-Children-OHK.py 18 54
./rules/MAGI-Children-OHK.py 19 55




# Get results to prove success

{
sqlite3 core.db <<-EOF
.separator "\t"
SELECT CaseID,  Result, flag FROM Case_Determinations;
.quit
EOF
} #>| rules/results/MAGI-Children-OHK_test-result

exit 0

