import datetime
import collections
import sqlite3
import sys

def failuremode(string):
	print(string)
	sys.exit(-1)

class load_determination(object):
	"""Class for holding contents of XML Receiver Section"""
	def __init__(self, autokey):
		self.result = None
		self.KeyID = autokey
		self.flag = ""

def commit(determination):
	if determination.result:
		determination.flag = "No issues"

	db = sqlite3.connect('file:core.db?mode=rw', uri=True)
	cursor = db.cursor()
	cursor.execute('''UPDATE Case_Determinations
		SET Result=?,
			Flag=?
		WHERE auto=?;''', (determination.result, determination.flag, determination.KeyID))
	db.commit()
