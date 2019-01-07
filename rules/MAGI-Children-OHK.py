#!/usr/bin/env python3
import sys
import std_case
import std_determination

def main(Applicant, determination):
	if (1 < Applicant.Age < 16 and 54 < Applicant.FPL <= 195) or (16 <= Applicant.Age < 19 and 54 < Applicant.FPL <= 109):
		determination.result = True

	if Applicant.Age >= 19:
		determination.result = False
		determination.flag = "Age of " + str(Applicant.Age) + " Greater than 19;"

	if 19 > Applicant.Age >= 16 and Applicant.FPL > 109:
		determination.result = False
		determination.flag = determination.flag + "Applicant age " + str(Applicant.Age) + " with FPL of " + str(Applicant.FPL) + " exceeds limit of 109"

	if 16 > Applicant.Age >= 1 and Applicant.FPL > 160:
		determination.result = False
		determination.flag = determination.flag + "Applicant age " + str(Applicant.Age) + " with FPL of " + str(Applicant.FPL) + " exceeds limit of 160"

	return determination

if __name__ == '__main__':
	Applicant = std_case.load_case(sys.argv[2])
	determination = std_determination.load_determination(sys.argv[1])
	determination = main(Applicant, determination)
	std_determination.commit(determination)
