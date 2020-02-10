FROM mcr.microsoft.com/windows/servercore/iis

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

EXPOSE 80

WORKDIR /inetpub/wwwroot

COPY app/ .