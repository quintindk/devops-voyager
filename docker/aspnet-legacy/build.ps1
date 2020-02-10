param (
    [Parameter(Mandatory=$true)][string]$version
)

Write-Output "get the published app"
mkdir app
Copy-Item ../../src/aspnet-legacy/bin/Release/Publish/* app/.

Write-Output "build container"
docker build -t voyager-legacy:$VERSION .

Write-Output "remove the app files"
Remove-Item -r app