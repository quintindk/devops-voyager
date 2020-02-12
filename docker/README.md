# docker

The is the future of deployment...

## docker file

### legacy windows service dockerfile

```dockerfile
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-1909

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

EXPOSE 80

WORKDIR /inetpub/wwwroot

COPY app/ .
```

### new python service dockerfile

```dockerfile
FROM python:3.6

WORKDIR /usr/src/app

COPY . .
RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]
```

## docker build

### legacy windows service build

I've create a small powershell script that will copy the latest published ASP.NET web service files and issue the build command to docker. This is mainly for local build and debug scenarios.

```powershell
./build.ps1 1.0.0
```

The above command will build the docker image legacy-voyager with the version specified.

### new python service service build

I've create a small shell script that will copy the latest python app files and issue the build command to docker. This is mainly for local build and debug scenarios.

```shell
./build.sh 1.0.0
```

The above command will build the docker image devops-voyager with the version specified.

## docker test

### legacy windows service build

```powershell
docker run -d --rm -p 8080:80 --name legacy-voyager legacy-voyager:2.0.0
```

### new python service service build

```shell
docker run -d --rm -p 127.0.0.1:5000:5000 --name voyager devops-voyager:1.0.1
```

## docker push

I've pushed and will continue to push the file to my own personal repository on [Docker Hub](https://hub.docker.com/).

```shell
docker tag devops-voyager:1.0.1 quintindk/devops-voyager:1.0.1
docker login
docker push quintindk/devops-voyager:1.0.1
```

And it's there, go have a look [https://hub.docker.com/r/quintindk/devops-voyager](https://hub.docker.com/r/quintindk/devops-voyager) :grinning:
