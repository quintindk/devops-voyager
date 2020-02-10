param (
    [Parameter(Mandatory=$true)][string]$version
)

Write-Output "get the published app"
mkdir Legacy-Service
Copy-Item -Path "../../src/aspnet-legacy/bin/Release/Publish/*" -Destination "Legacy-Service" -Recurse

Write-Output "build container"
docker build -t legacy-voyager:$VERSION .
docker tag legacy-voyager:$VERSION legacy-voyager:latest

Write-Output "remove the app files"
Remove-Item -r Legacy-Service