$resourceGroupLocation="fake"
$resourceGroupName = 'fake'
$resourceGroup = az group list --query "[].{Name:name,Location:location}" --output table
$acrName = 'fake'
$acr = az acr list --query "[].{Name:name}" --output table
$aksName = "fake"

if(!$resourceGroup)
{
    Write-Host "Resource group '$resourceGroupName' does not exist. To create a new resource group, please enter a location.";
    if(!$resourceGroupName) {
        $resourceGroupName = Read-Host "resourceGroupName";
    }
    Write-Host "Creating resource group '$resourceGroupName' in location '$resourceGroupLocation'";
    az group create -n $resourceGroupName -l $resourceGroupLocation
}
else{
    Write-Host "Using existing resource group '$resourceGroupName'";
}
if(!$acr)
{
    Write-Host "ACR '$acrName' does not exist"
    if(!$acrName) { 
    $acrName =  Read-Host "acrName";
    }
    Write-Host "Creating ACR '$acrName'";
    az acr create -n $acrName -r $resourceGroupName --sku Standard
else{
    Write-Host "Using existing ACR '$acrName'";
}

Write-Host "Creating AKS"

function AKS-Create ($resourceGroupName,$aksName){ 
    $akscreate = az aks create -g $resourceGroupName -n $aksName --node-count 1
    Write-Host "AKS Created"

}
