#!/usr/bin/env python3
import sys
import std_case
import std_determination

def main(Applicant, determination):
	if Applicant.Age < 1 and 54 < Applicant.FPL <= 195:
		determination.result = True

	if Applicant.Age >= 1:
		determination.result = False
		determination.flag = "Age of " + str(Applicant.Age) + " is not under 1 year old;"

	if 54 >= Applicant.FPL or Applicant.FPL > 195:
		determination.result = False
		determination.flag = determination.flag + "FPL of " + str(Applicant.FPL) + " Not in range of 54-195"

	return determination

if __name__ == '__main__':
	Applicant = std_case.load_case(sys.argv[2])
	determination = std_determination.load_determination(sys.argv[1])
	determination = main(Applicant, determination)
	std_determination.commit(determination)
