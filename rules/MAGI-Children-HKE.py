#!/usr/bin/env python3
import sys
import std_case
import std_determination

def main(Applicant, determination):
	if 16 <= Applicant.Age < 19 and 109 < Applicant.FPL <= 160:
		determination.result = True

	if 16 > Applicant.Age or Applicant.Age >= 19:
		determination.result = False
		determination.flag = "Age of " + str(Applicant.Age) + " Greater than is not in range of 16-18;"

	if 109 >= Applicant.FPL or Applicant.FPL > 160:
		determination.result = False
		determination.flag = determination.flag + "FPL of " + str(Applicant.FPL) + " not in range of 109 and 160"

	return determination

if __name__ == '__main__':
	Applicant = std_case.load_case(sys.argv[2])
	determination = std_determination.load_determination(sys.argv[1])
	determination = main(Applicant, determination)
	std_determination.commit(determination)
