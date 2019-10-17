# docker

The is the future of deployment...

## docker file

```dockerfile
FROM python:3.6

WORKDIR /usr/src/app

COPY . .
RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]
```

The above docker file will copy the files from the docker folder, use the official Python 3.6 base image [https://hub.docker.com/_/python](https://hub.docker.com/_/python).

## docker build

I've create a small shell script that will copy the latest app.py file and issue the build command to docker, This is mainly for local build and debug scenarios.

```shell
./build.sh 1.0.0
```

The above command will build the docker image devops-voyager with the version specified.
