$client = Read-Host -Prompt "Client name"
$password = Read-Host -Prompt "Password"
$subject = Read-Host -Prompt "Certififcate subject"
$dns = Read-Host -Prompt "DNS name"

$rootCA = New-SelfSignedCertificate -CertStoreLocation "cert:\CurrentUser\my\" `
    -DnsName "$dns Root Cert" -KeyExportPolicy "Exportable" `
    -KeyUsage "CertSign","CRLSign" -Extension

$cert = New-SelfSignedCertificate -Signer $rootCA -CertStoreLocation "cert:\CurrentUser\my\" `
    -Subject "$subject" -DnsName "$dns"

$pfxpath = ".\$client.pfx"
$rootpath = ".\$client.cer"

$certpath = "cert:\CurrentUser\my\" + $cert.thumbprint
$pass = ConvertTo-SecureString -String "$password" -AsPlainText
Export-Certificate -Cert $rootCA -FilePath $rootpath -Type "CERT"
Export-PfxCertificate -cert $certpath -FilePath "$pfxpath" -Password $pass



Import-Module -Name Az.ApiManagement

# # root CA
# $apirootca = New-AzApiManagementSystemCertificate -StoreName "CertifiacteAuthority" -PfxPath $rootpath -PfxPassword $password
# $apim = Get-AzApiManagement -ResourceGroupName "rgdevdirecttransact" -Name "quintintesting"
# $apim.SystemCertificates.Add($apirootca)
# Set-AzApiManagement -InputObject $apim -PassThru

# # customer certificate
# $context = New-AzApiManagementContext -ResourceGroupName "rgdevdirecttransact" -ServiceName "quintintesting"
# $certs = Get-AzApiManagementCertificate -Context $context
# if ($certs.Where({ $_.CertificateId -eq $client}, 'First').Count -gt 0) {
#     $response = Read-Host -Prompt "Replace"
#     if ($response.Contains("y")) {
#         Remove-AzApiManagementCertificate -Context $context -CertificateId "$client"
#     }
# }
# Set-AzApiManagementCertificate -Context $context -CertificateId "$client" -PfxFilePath  "$pfxpath" -PfxPassword $password