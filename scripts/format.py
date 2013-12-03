# format.py

import os
import os.path
import csv
import re

_digits = re.compile('\d')
def contains_digits(d):
    return bool(_digits.search(d)) and ("." in d)

textfile = None
mypath="Dropbox/workspace/coursework/act/act_proj/results"
for dirpath, dirnames, filenames in os.walk(mypath):
    for filename in [f for f in filenames if f.endswith(".txt")]:
        textfile = os.path.join(dirpath, filename)
        duke = not ("noduke" in textfile)
        goodrows = []
        with open(textfile, 'r') as csvfile:
            reader = csv.reader(csvfile, delimiter="\n")
            for row in reader:
                if row and contains_digits(row[0]):
                    goodrows.append(row[0])
            oddrows, evenrows = [], []
            for gr in goodrows:
                toapp = gr.split(" ")
                toapp = [j for j in toapp if j]
                if toapp[0] == 'beta':
                    oddrows.extend(toapp[1:])
                elif toapp[0] == 'inclusion':
                    evenrows.extend(toapp[1:])
            # print(oddrows)
            # print(evenrows)
        finalrow = []
        for i in range(len(oddrows)):
            finalrow.append(oddrows[i])
            finalrow.append(evenrows[i])
        if duke:
            finalrow = finalrow[-2:] + finalrow[:-2]
        with open(textfile+"_NEW.csv", 'w+') as csvout:
            writer = csv.writer(csvout)
            for fr in finalrow:
                writer.writerow([round(float(fr), 3)])
