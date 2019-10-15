FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install -r requirements.txt

ENV FLASK_ENV=development
ENV FLASK_APP=app.py

EXPOSE 5000

COPY . .

CMD [ "python", "-m", "flask", "run" ]