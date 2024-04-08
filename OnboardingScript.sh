
export subscriptionId="020c20b0-7fac-4a45-80d1-983f565c2e07";
export resourceGroup="Sentinel";
export tenantId="5b729122-84e3-4a9c-b67a-b28e8b3a670c";
export location="northeurope";
export authType="token";
export correlationId="f83f8981-a7d1-48fa-9c45-d6e72e30602b";
export cloud="AzureCloud";


# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";
