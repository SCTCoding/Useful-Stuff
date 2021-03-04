#! /bin/bash

pGroup=$(/usr/bin/curl -L "https://my.vmware.com/channel/public/api/v1.0/products/getRelatedDLGList?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&version=horizon_8&dlgType=PRODUCT_BINARY" | /usr/bin/grep -Eo '"code":.*?[^\\]",' | /usr/bin/head -n 2 | /usr/bin/tail -n 1 | /usr/bin/awk -F '"' '{print $4}')

productId=$(/usr/bin/curl -L "https://my.vmware.com/channel/public/api/v1.0/products/getRelatedDLGList?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&version=horizon_8&dlgType=PRODUCT_BINARY" | /usr/bin/grep -Eo '"productId":.*?[^\\]",'| /usr/bin/head -n 2 | /usr/bin/tail -n 1 | /usr/bin/awk -F '"' '{print $4}')

pID=$(/usr/bin/curl -L "https://my.vmware.com/channel/public/api/v1.0/products/getRelatedDLGList?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&version=horizon_8&dlgType=PRODUCT_BINARY" | /usr/bin/grep -Eo '"releasePackageId":.*?[^\\]",' | /usr/bin/head -n 2 | /usr/bin/tail -n 1 | /usr/bin/awk -F '"' '{print $4}')


downloadLocation="https://my.vmware.com/web/vmware/downloads/details?downloadGroup=${pGroup}&productId=${prodID}&rPId=${pID}"

echo "Product Group: $pGroup"
echo "Product ID: $productId"
echo "Release Package ID: $pID"
echo "Download URL: $downloadLocation"