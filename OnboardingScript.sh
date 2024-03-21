# Add the service principal application ID and secret here
ServicePrincipalId="9bc69471-c265-496f-8d01-8c375c94923f";
ServicePrincipalClientSecret="z-o8Q~VzdvNBBrxkixbF8VtpJYG~-mxI8vvZXbVl";


export subscriptionId="61813e03-3991-4886-a129-7cb2828e0fa1";
export resourceGroup="Joe-arc-rg";
export tenantId="9ad0016a-02f4-40eb-a782-a2d475c3baf6";
export location="francecentral";
export authType="principal";
export correlationId="170593c5-4036-473c-a4ca-0ab84e9256ac";
export cloud="AzureCloud";


# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --service-principal-id "$ServicePrincipalId" --service-principal-secret "$ServicePrincipalClientSecret" --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";
