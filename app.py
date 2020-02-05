import csv
import random
import json
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
  return 'Server Works!'
  
@app.route('/greet')
@app.route('/greet/<language>')
def api_greet(language = None):
  greetings = get_greetings()
    
  if (language == None):
    greeting = random.randint(1, len(greetings)-1)
    return json.dumps(greetings[greeting][1])
  else:
    return json.dumps(greetings[get_languageindex(language)][1])

@app.route('/languages')
def api_languages():
  return json.dumps(get_languages())

def get_greetings():
  with open('data.csv', 'r') as f:
    reader = csv.reader(f)
    greetings = list(reader)
  return greetings

def get_languages():
  greetings = get_greetings()
  languages = list()
  for i in range(len(greetings)):
      languages.append(greetings[i][0])
  return languages

def get_languageindex(language):
  languages = get_languages()
  for i in range(len(languages)):
    if (languages[i] == language):
      return i

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')