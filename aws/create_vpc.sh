alias awsc='aws --profile datadeft-dev --region eu-west-1'

awsc ec2 create-dhcp-options \
--dhcp-configurations '{"Key":"domain-name","Values":["eu-west-1.compute.internal"]}' '{"Key":"domain-name-servers","Values":["AmazonProvidedDNS"]}' '{"Key":"ntp-servers","Values":["131.234.220.231","195.186.1.101","213.136.0.252","45.87.78.35"]}'


awsc ec2 create-vpc --cidr-block 172.30.0.0/21


# {
#     "Vpc": {
#         "CidrBlock": "172.30.0.0/21",
#         "DhcpOptionsId": "dopt-0cddf069",
#         "State": "pending",
#         "VpcId": "vpc-04f56576b19861c73",
#         "OwnerId": "651831719661",
#         "InstanceTenancy": "default",
#         "Ipv6CidrBlockAssociationSet": [],
#         "CidrBlockAssociationSet": [
#             {
#                 "AssociationId": "vpc-cidr-assoc-0d6d30a460342d558",
#                 "CidrBlock": "172.30.0.0/21",
#                 "CidrBlockState": {
#                     "State": "associated"
#                 }
#             }
#         ],
#         "IsDefault": false
#     }
# }


vpc_id="vpc-04f56576b19861c73"
dhcp_options_id="dopt-03b6e856dd51282c4"


awsc ec2 associate-dhcp-options \
  --dhcp-options-id "${dhcp_options_id}" \
  --vpc-id "${vpc_id}"


awsc ec2 create-tags \
  --resources "${vpc_id}" \
  --tags Key=Name,Value="datadeft-dev"


awsc ec2 create-tags \
  --resources "${dhcp_options_id}" \
  --tags Key=Name,Value="datadeft-dev-dhcp"


awsc ec2 modify-vpc-attribute \
  --vpc-id "${vpc_id}" \
  --enable-dns-support "{\"Value\":true}")


awsc ec2 modify-vpc-attribute \
  --vpc-id "${vpc_id}" \
  --enable-dns-hostnames "{\"Value\":true}")


awsc ec2 create-internet-gateway

# {
#     "InternetGateway": {
#         "Attachments": [],
#         "InternetGatewayId": "igw-0220f6566f7b499e0",
#         "OwnerId": "651831719661",
#         "Tags": []
#     }
# }

internet_gw="igw-0220f6566f7b499e0"


awsc ec2 create-tags \
  --resources "${internet_gw}" \
  --tags Key=Name,Value="datadeft-dev-ig"


awsc ec2 attach-internet-gateway \
 --internet-gateway-id "${internet_gw}"  \
 --vpc-id "${vpc_id}"


awsc ec2 create-subnet \
 --cidr-block "172.30.0.0/24" \
 --availability-zone "eu-west-1a" \
 --vpc-id "${vpc_id}" \
 --output json

# {
#     "Subnet": {
#         "AvailabilityZone": "eu-west-1a",
#         "AvailabilityZoneId": "euw1-az2",
#         "AvailableIpAddressCount": 251,
#         "CidrBlock": "172.30.0.0/24",
#         "DefaultForAz": false,
#         "MapPublicIpOnLaunch": false,
#         "State": "available",
#         "SubnetId": "subnet-00fed7da7ab956343",
#         "VpcId": "vpc-04f56576b19861c73",
#         "OwnerId": "651831719661",
#         "AssignIpv6AddressOnCreation": false,
#         "Ipv6CidrBlockAssociationSet": [],
#         "SubnetArn": "arn:aws:ec2:eu-west-1:651831719661:subnet/subnet-00fed7da7ab956343"
#     }
# }


awsc ec2 create-subnet \
 --cidr-block "172.30.1.0/24" \
 --availability-zone "eu-west-1b" \
 --vpc-id "${vpc_id}" \
 --output json

# {
#     "Subnet": {
#         "AvailabilityZone": "eu-west-1b",
#         "AvailabilityZoneId": "euw1-az1",
#         "AvailableIpAddressCount": 251,
#         "CidrBlock": "172.30.1.0/24",
#         "DefaultForAz": false,
#         "MapPublicIpOnLaunch": false,
#         "State": "available",
#         "SubnetId": "subnet-0311997500275ee41",
#         "VpcId": "vpc-04f56576b19861c73",
#         "OwnerId": "651831719661",
#         "AssignIpv6AddressOnCreation": false,
#         "Ipv6CidrBlockAssociationSet": [],
#         "SubnetArn": "arn:aws:ec2:eu-west-1:651831719661:subnet/subnet-0311997500275ee41"
#     }
# }


awsc ec2 create-subnet \
 --cidr-block "172.30.2.0/24" \
 --availability-zone "eu-west-1c" \
 --vpc-id "${vpc_id}" \
 --output json


# {
#     "Subnet": {
#         "AvailabilityZone": "eu-west-1c",
#         "AvailabilityZoneId": "euw1-az3",
#         "AvailableIpAddressCount": 251,
#         "CidrBlock": "172.30.2.0/24",
#         "DefaultForAz": false,
#         "MapPublicIpOnLaunch": false,
#         "State": "available",
#         "SubnetId": "subnet-0c474333956cf6c86",
#         "VpcId": "vpc-04f56576b19861c73",
#         "OwnerId": "651831719661",
#         "AssignIpv6AddressOnCreation": false,
#         "Ipv6CidrBlockAssociationSet": [],
#         "SubnetArn": "arn:aws:ec2:eu-west-1:651831719661:subnet/subnet-0c474333956cf6c86"
#     }
# }


subnet_1a_id="subnet-00fed7da7ab956343"
subnet_1b_id="subnet-0311997500275ee41"
subnet_1c_id="subnet-0c474333956cf6c86"


for sn in "${subnet_1a_id}" "${subnet_1b_id}" "${subnet_1c_id}"; do

  echo "${sn}"

  awsc ec2 modify-subnet-attribute \
  --subnet-id "${sn}" \
  --map-public-ip-on-launch

done


awsc ec2 create-tags \
  --resources "${subnet_1a_id}" \
  --tags Key=Name,Value="datadeft-dev-1a-public"


awsc ec2 create-tags \
  --resources "${subnet_1b_id}" \
  --tags Key=Name,Value="datadeft-dev-1b-public"


awsc ec2 create-tags \
  --resources "${subnet_1c_id}" \
  --tags Key=Name,Value="datadeft-dev-1c-public"


awsc ec2 create-security-group \
 --group-name "ml-datadeft-dev-sg" \
 --description "Allow SSH" \
 --vpc-id "${vpc_id}" \
 --output json

# {
#     "GroupId": "sg-07edf7ce20415dac2"
# }


ml_datadeft_dev_sg="sg-07edf7ce20415dac2"


awsc ec2 create-tags \
  --resources "${ml_datadeft_dev_sg}" \
  --tags Key=Name,Value="ml-datadeft-dev-sg"


awsc ec2 authorize-security-group-ingress \
 --group-id "${ml_datadeft_dev_sg}" \
 --protocol tcp --port 22 \
 --cidr "$my_ip"


routing_table="rtb-0c3b67cac45d08d68"


awsc ec2 create-tags \
  --resources "${routing_table}" \
  --tags Key=Name,Value="datadeft-dev-rtb"


awsc ec2 create-route \
 --route-table-id "${routing_table}" \
 --destination-cidr-block "0.0.0.0/0" \
 --gateway-id "${internet_gw}"


# {
#     "Return": true
# }


for sn in "${subnet_1a_id}" "${subnet_1b_id}" "${subnet_1c_id}"; do

  echo "${sn}"

  awsc ec2 associate-route-table \
  --subnet-id "${sn}" \
  --route-table-id "${routing_table}"

done


# subnet-00fed7da7ab956343
# {
#     "AssociationId": "rtbassoc-0e00ea291e747d7d0",
#     "AssociationState": {
#         "State": "associated"
#     }
# }
# subnet-0311997500275ee41
# {
#     "AssociationId": "rtbassoc-048280506b57b5d18",
#     "AssociationState": {
#         "State": "associated"
#     }
# }
# subnet-0c474333956cf6c86
# {
#     "AssociationId": "rtbassoc-0fe4d53bfb97f532f",
#     "AssociationState": {
#         "State": "associated"
#     }
# }

awsc ec2 create-vpc-endpoint \
--vpc-endpoint-type "Gateway" \
--vpc-id "${vpc_id}" \
--service-name "com.amazonaws.eu-west-1.s3" \
--route-table-ids "${routing_table}"

# {
#     "VpcEndpoint": {
#         "VpcEndpointId": "vpce-080701259f6b00f69",
#         "VpcEndpointType": "Gateway",
#         "VpcId": "vpc-04f56576b19861c73",
#         "ServiceName": "com.amazonaws.eu-west-1.s3",
#         "State": "available",
#         "PolicyDocument": "{\"Version\":\"2008-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"*\",\"Resource\":\"*\"}]}",
#         "RouteTableIds": [
#             "rtb-0c3b67cac45d08d68"
#         ],
#         "SubnetIds": [],
#         "Groups": [],
#         "PrivateDnsEnabled": false,
#         "RequesterManaged": false,
#         "NetworkInterfaceIds": [],
#         "DnsEntries": [],
#         "CreationTimestamp": "2021-04-13T13:48:07+00:00",
#         "OwnerId": "651831719661"
#     }
# }
