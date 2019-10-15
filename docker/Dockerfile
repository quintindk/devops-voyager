FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip3 install flask

ENV FLASK_ENV=development
ENV FLASK_APP=app.py

COPY . .

CMD [ "python", "-m", "flask", "run" ]