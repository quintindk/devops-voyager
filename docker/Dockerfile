FROM python:3.6

WORKDIR /usr/src/app

COPY . .
RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]