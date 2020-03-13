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