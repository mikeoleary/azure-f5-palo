param(
    [string] $url
    )

#every 30 secs for 10 mins, check if app server is up yet
$i=0
write-output 'setting i to 0'
while ($i -lt 20) {
    try {
        write-output $('attempt number'+$i)
        $response = Invoke-WebRequest -URI $url -UseBasicParsing
        $StatusCode = $response.StatusCode 
    }
    catch {
        $StatusCode = $_.Exception.Response.StatusCode.value__
    }
    if ($StatusCode -eq '200') {
        break;
    }
    else {
        $i++
        Start-Sleep 30
    }
}
if (!($StatusCode -eq '200')) {
    $output = $StatusCode
    throw $url+' is not available, status code is '+$StatusCode
    }
$output = $StatusCode
Write-Output $output
#$DeploymentScriptOutputs = @{}
#$DeploymentScriptOutputs['text'] = $output