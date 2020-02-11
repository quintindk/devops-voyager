FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019
SHELL ["powershell"]

RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \
    Install-WindowsFeature Web-Asp-Net45

COPY Legacy-Service Legacy-Service

RUN Remove-WebSite -Name 'Default Web Site'
RUN New-Website -Name 'Legacy-Service' -Port 80 \
    -PhysicalPath 'c:\Legacy-Service' -ApplicationPool '.NET v4.5'

EXPOSE 80