#! /usr/bin/pwsh

$resourcegroup = Read-Host -Prompt 'Enter the name of the resource group'
$servicename = Read-Host -Prompt 'Enter the name of the APIM service'
$rootpath = Read-Host -Prompt "Provide CA cert name"
$client = Read-Host -Prompt "Enter the client name"
$password = Read-Host -Prompt "Enter the client PFX Password"
$subject = Read-Host -Prompt "Enter the client certififcate subject"
$dns = Read-Host -Prompt "Enter the client DNS name"

$rootCA = Import-Certificate -FilePath $rootpath -CertStoreLocation "cert:\CurrentUser\Root\"
$rootCA = Import-Certificate -FilePath $rootpath -CertStoreLocation "cert:\CurrentUser\my\"
$cert = New-SelfSignedCertificate -Signer $rootCA -CertStoreLocation "cert:\CurrentUser\my\" `
    -Subject "$subject" -DnsName "$dns"
$certpath = "cert:\CurrentUser\my\" + $cert.thumbprint
Export-PfxCertificate -cert $certpath -FilePath "$pfxpath" -Password $pass

Import-Module -Name Az.ApiManagement

# root CA
$apirootca = New-AzApiManagementSystemCertificate -StoreName "CertificateAuthority" -PfxPath $rootpath
$apim = Get-AzApiManagement -ResourceGroupName "$resourcegroup" -Name "$servicename"
$apim.SystemCertificates.Add($apirootca)
Set-AzApiManagement -InputObject $apim -PassThru

# customer certificate
$context = New-AzApiManagementContext -ResourceGroupName "$resourcegroup" -ServiceName "$servicename"
$certs = Get-AzApiManagementCertificate -Context $context
if ($certs.Where({ $_.CertificateId -eq $client}, 'First').Count -gt 0) {
    $response = Read-Host -Prompt "Replace the certificate? [y/N]"
    if ($response.Contains("y")) {
        Remove-AzApiManagementCertificate -Context $context -CertificateId "$client"
    }
}
Set-AzApiManagementCertificate -Context $context -CertificateId "$client" -PfxFilePath "$pfxpath" -PfxPassword $password