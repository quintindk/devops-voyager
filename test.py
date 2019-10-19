import csv
import random

with open('data.csv', 'r') as f:
  reader = csv.reader(f)
  greetings = list(reader)

greeting = random.randint(1, len(greetings)-1)
print(greetings)
print(greetings[greeting])
print(greetings[greeting][1])

languages = list()
for i in range(len(greetings)):
    languages.append(greetings[i][0])
print(languages)
