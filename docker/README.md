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

## docker push

I've pushed and will continue to push the file to my own personal repository on [Docker Hub](https://hub.docker.com/).

```shell
docker tag devops-voyager:1.0.0 quintindk/devops-voyager:1.0.0
docker login
docker push quintindk/devops-voyager:1.0.0
```

And it's there, go have a look [https://hub.docker.com/r/quintindk/devops-voyager](https://hub.docker.com/r/quintindk/devops-voyager) :grinning:
