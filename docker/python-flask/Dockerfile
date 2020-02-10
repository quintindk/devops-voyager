FROM python:3.6

WORKDIR /usr/src/app

COPY app.py .
COPY requirements.txt .
COPY data.csv .
RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]