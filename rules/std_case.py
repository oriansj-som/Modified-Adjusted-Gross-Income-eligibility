import datetime
import collections
import sqlite3
import sys

def failuremode(string):
	print(string)
	sys.exit(-1)

class load_case(object):
	"""Class for holding Case"""
	def __init__(self, CaseID):
		db = sqlite3.connect('file:core.db?mode=ro', uri=True)
		cursor = db.cursor()
		cursor.execute('''SELECT CaseID, Age,FPL, Gender, Pregnant, ComprehensiveInsurance, Caretaker
			FROM CaseID
			WHERE CaseID=?;''', (CaseID,))
		results = cursor.fetchall();

		self.CaseID = int(results[0][0])
		self.Age = float(results[0][1])
		self.FPL = float(results[0][2])
		self.Gender = results[0][3]
		self.Pregnant = bool(results[0][4])
		self.ComprehensiveInsurance = bool(results[0][5])
		self.Caretaker = bool(results[0][6])
