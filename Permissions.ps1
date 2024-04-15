
    $CertCN="ipservices.ibex.co"

    $sslCert = gci Cert:\LocalMachine\My | WHERE {$_.Subject -match "$CertCN"}
    $sslCertPrivKey = $sslCert.PrivateKey
    $privKeyCertFile = Get-Item -path "$ENV:ProgramData\Microsoft\Crypto\RSA\MachineKeys\*" | WHERE {$_.Name -eq $sslCertPrivKey.CspKeyContainerInfo.UniqueKeyContainerName}
    $privKeyAcl = (Get-Item -Path $privKeyCertFile.FullName).GetAccessControl("Access")
    $permission = "Authenticated Users","Read","Allow"
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $privKeyAcl.AddAccessRule($accessRule)
    Set-Acl $privKeyCertFile.FullName $privKeyAcl
    exit