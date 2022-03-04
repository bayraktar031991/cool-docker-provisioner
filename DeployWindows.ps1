param (
    [string] $Sufix,
    [ValidateSet(“S1”,”S2”,”S3”)]
    [string] $PlanSize,
    [int] $DockerInstanceNo
)

$appservice_no=$DockerInstanceNo;
$plan_size=$PlanSize

$prefix = -join ((97..122) | Get-Random -Count 6 | % {[char]$_})
$rg_name="demo_$Sufix"
$reg_name="$($prefix)0reg$($Sufix)"
$plan_name="$($prefix)0demo_plan_$($Sufix)"
$service_name="$($prefix)0demo$($Sufix)"
$image_name="$($prefix)0demo$($Sufix)"
$location="eastus"

if((az group exists --name $rg_name) -eq $true){
    az group delete -n $rg_name --yes 
}

az group create --name $rg_name --location $location
az acr create --name $reg_name --resource-group $rg_name --sku standard --admin-enabled true
az acr build --file Dockerfile --registry $reg_name --image $image_name .

az appservice plan create --name $plan_name --resource-group $rg_name --sku $plan_size --is-linux

1..$appservice_no |
%{
    az webapp create --resource-group $rg_name --plan $plan_name --name "$($service_name)-$($_)" --deployment-container-image-name "$($reg_name).azurecr.io/$($image_name):latest"
}


