#!/usr/bin/python
import argparse

parser = argparse.ArgumentParser(description='Cleanup Mapleleaves program tables')

#parser.add_argument('inputFile', metavar='1', type=string
#parser.add_argument('inputFile', help='original table snippet from Gnumeric', dest='inputFile')
parser.add_argument('inputFile', help='original table snippet from Gnumeric')
parser.add_argument('outputFile', help='new file with clean html')

args = parser.parse_args()
#print vars(args)
#argparse.Namespace(origFile='inputFile')

print 'Sanitising {0}'.format(args.inputFile)
print 'Writing to {0}'.format(args.outputFile)

#origFile = open(args['inputFile'], 'r')
origFile = open(args.inputFile, 'r')
cleanFile = open(args.outputFile, 'w')

#thisLine = origFile.readline()
#print thisLine

inHeader = False

for thisLine in origFile.readlines():
	thisLine = thisLine.strip()
	# regular strippage
	thisLine = thisLine.replace(' font-size:9pt;', '').replace(' font-size:10pt;', '').replace(' font-size:11pt;', '').replace('  style=""', '').replace('  valign="bottom"', '').replace('  ', ' ').replace('<b></b>', '')
	thisLine = thisLine.replace('<i>', '').replace('</i>', '').replace('<b></b>', '').replace('<td></td>', '<td>&nbsp;</td>')

	lineSoFar = thisLine

	# if it is a table header
	thisLine = thisLine.replace('<td align="left"><b>Datum</b></td>', '<th align="left">Datum</th>')
	thisLine = thisLine.replace('<td align="left"><b>Tijd</b></td>', '<th align="left">Tijd</th>')
	thisLine = thisLine.replace('<td align="center"><b>Tijd</b></td>', '<th align="center">Tijd</th>')
	thisLine = thisLine.replace('<td align="center"><b>Veld</b></td>', '<th align="center">Veld</th>')
	thisLine = thisLine.replace('<td align="left"><b>Poule</b></td>', '<th align="left">Poule</th>')
	thisLine = thisLine.replace('<td align="center"><b>Code</b></td>', '<th align="center">Code</th>')
	thisLine = thisLine.replace('<td align="left"><b>Team Thuis</b></td>', '<th align="left">Team Thuis</th>')
	thisLine = thisLine.replace('<td align="left"><b>Team Uit</b></td>', '<th align="left">Team Uit</th>')
	thisLine = thisLine.replace('<td align="left"><b>Plaats/Sporthal</b></td>', '<th align="left">Plaats/Sporthal</th>')
	thisLine = thisLine.replace('<td align="left"><b>Scheidsrechters</b></td>', '<th align="left">Scheidsrechters</th>')
	thisLine = thisLine.replace('<td align="left"><b>Schrijvers</b></td>', '<th align="left">Schrijvers</th>')
	thisLine = thisLine.replace('<td align="left"><b>Zaaldienst</b></td>', '<th align="left">Zaaldienst</th>')
	thisLine = thisLine.replace('<td align="left"><b>Vertrektijd</b></td>', '<th align="left">Vertrektijd</th>')

	thisLine = thisLine.replace('<td align="left"><b>Veld</b></td>', '<th align="left">Veld</th>')
	thisLine = thisLine.replace('<td align="left"><b>Code</b></td>', '<th align="left">Code</th>')
	thisLine = thisLine.replace('<td align="left"><b>Thuis</b></td>', '<th align="left">Thuis</th>')
	thisLine = thisLine.replace('<td align="left"><b>Uit</b></td>', '<th align="left">Uit</th>')
	thisLine = thisLine.replace('<td align="left"><b>Hal</b></td>', '<th align="left">Hal</th>')
	thisLine = thisLine.replace('<td align="left"><b>Adres</b></td>', '<th align="left">Adres</th>')
	thisLine = thisLine.replace('<td align="left"><b>postcode</b></td>', '<th align="left">Postcode</th>')
	thisLine = thisLine.replace('<td align="left"><b>Plaats</b></td>', '<th align="left">Plaats</th>')
	thisLine = thisLine.replace('<td align="center"><b>Vertrektijd</b></td>', '<th align="center">Vertrektijd</th>')

	thisLine = thisLine.replace('<td align="left"><b>Scheidsrechter</b></td>', '<th align="left">Scheidsrechter</th>')
	thisLine = thisLine.replace('<td align="center"><b>Zaaldienst</b></td>', '<th align="center">Zaaldienst</th>')

	if (thisLine != lineSoFar):
		inHeader = True

	if (inHeader):
		thisLine = thisLine.replace('<td>&nbsp;</td>', '<th>&nbsp;</th>')
		if thisLine == '</tr>':
			inHeader = False

	#print thisLine
	cleanFile.write(thisLine + '\n')

origFile.close()
cleanFile.close()
