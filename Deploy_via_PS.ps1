## Script parameters being asked for below match to parameters in the azuredeploy.json file, otherwise pointing to the ##
## azuredeploy.parameters.json file for values to use.  Some options below are mandatory, some (such as region) can    ##
## be supplied inline when running this script but if they aren't then the default will be used as specified below.    ##
## Example Command: .\Deploy_via_PS.ps1 -adminUsername azureuser -authenticationType password -adminPasswordOrKey <value> -dnsLabel <value> -instanceName f5vm01 -numberOfExternalIps 1 -enableNetworkFailover Yes -internalLoadBalancerType Per-protocol -internalLoadBalancerProbePort 3456 -instanceType Standard_DS3_v2 -imageName Best1Gbps -bigIpVersion 15.0.100000 -bigIpModules ltm:nominal -vnetAddressPrefix 10.0 -declarationUrl NOT_SPECIFIED -ntpServer 0.pool.ntp.org -timeZone UTC -customImage OPTIONAL -allowUsageAnalytics Yes -resourceGroupName <value>

param(

  [string] [Parameter(Mandatory=$True)] $adminUsername,
  #[string] [Parameter(Mandatory=$True)] $authenticationType,
  [string] [Parameter(Mandatory=$True)] $password,
  [string] [Parameter(Mandatory=$True)] $dnsLabel,
  #[string] [Parameter(Mandatory=$True)] $instanceName,
  #[string] [Parameter(Mandatory=$True)] $numberOfExternalIps,
  #[string] [Parameter(Mandatory=$True)] $enableNetworkFailover,
  #[string] [Parameter(Mandatory=$True)] $internalLoadBalancerType,
  #[string] [Parameter(Mandatory=$True)] $internalLoadBalancerProbePort,
  #[string] [Parameter(Mandatory=$True)] $instanceType,
  #[string] [Parameter(Mandatory=$True)] $imageName,
  #[string] [Parameter(Mandatory=$True)] $bigIpVersion,
  #[string] [Parameter(Mandatory=$True)] $bigIpModules,
  #[string] [Parameter(Mandatory=$True)] $vnetAddressPrefix,
  #[string] [Parameter(Mandatory=$True)] $declarationUrl,
  #[string] [Parameter(Mandatory=$True)] $ntpServer,
  #[string] [Parameter(Mandatory=$True)] $timeZone,
  #[string] [Parameter(Mandatory=$True)] $customImage,
  #[string] $restrictedSrcAddress = "*",
  #$tagValues = '{"application": "APP", "cost": "COST", "environment": "ENV", "group": "GROUP", "owner": "OWNER"}',
  #[string] [Parameter(Mandatory=$True)] $allowUsageAnalytics,
  [string] [Parameter(Mandatory=$True)] $resourceGroupName,
  [string] [Parameter(Mandatory=$True)] $region,
  [string] $templateFilePath = "deploy.json"
  #[string] $parametersFilePath = "deploy.parameters.json"
)

Write-Host "Disclaimer: Scripting to Deploy F5 Solution templates into Cloud Environments are provided as examples. They will be treated as best effort for issues that occur, feedback is encouraged." -foregroundcolor green
Start-Sleep -s 3

# Connect to Azure, right now it is only interactive login
try {
    Write-Host "Checking if already logged in!"
    Get-AzureRmSubscription | Out-Null
    Write-Host "Already logged in, continuing..."
    }
    catch {
      Write-Host "Not logged in, please login..."
      Login-AzureRmAccount
    }

# Create Resource Group for ARM Deployment
New-AzureRmResourceGroup -Name $resourceGroupName -Location "$region" -Force

$adminPasswordOrKeySecure = ConvertTo-SecureString -String $password -AsPlainText -Force

#(ConvertFrom-Json $tagValues).psobject.properties | ForEach -Begin {$tagValues=@{}} -process {$tagValues."$($_.Name)" = $_.Value}

# Create Arm Deployment
$deployment = New-AzureRmResourceGroupDeployment -Name $resourceGroupName -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath -Verbose -adminUsername $adminUsername -password $adminPasswordOrKeySecure -dnsLabel $dnsLabel

# Print Output of Deployment to Console
$deployment