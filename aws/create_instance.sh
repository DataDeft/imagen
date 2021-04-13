alias awsc='aws --profile datadeft-dev --region eu-west-1'

awsc ec2 create-launch-template \
--launch-template-name ml-datadeft-dev
--launch-template-data '
{
    "LaunchTemplateVersions": [
        {
            "LaunchTemplateId": "lt-02a7f441764e12005",
            "LaunchTemplateName": "ml-datadeft-dev",
            "VersionNumber": 1,
            "VersionDescription": "ml-datadeft-dev",
            "CreateTime": "2021-04-13T13:55:08+00:00",
            "CreatedBy": "arn:aws:iam::651831719661:user/istvan",
            "DefaultVersion": true,
            "LaunchTemplateData": {
                "IamInstanceProfile": {
                    "Arn": "arn:aws:iam::651831719661:instance-profile/dev/hu/dev-ml-datadeft-instance-profile"
                },
                "ImageId": "ami-00ad6b44adca6dc28",
                "InstanceType": "g4dn.2xlarge",
                "KeyName": "datadeft-dev-eu-west-1",
                "Monitoring": {
                    "Enabled": false
                },
                "DisableApiTermination": false,
                "InstanceInitiatedShutdownBehavior": "terminate",
                "SecurityGroupIds": [
                    "sg-07edf7ce20415dac2"
                ],
                "InstanceMarketOptions": {
                    "MarketType": "spot",
                    "SpotOptions": {
                        "MaxPrice": "0.5"
                    }
                }
            }
        }
    ]
}
'

awsc ec2 run-instances --launch-template LaunchTemplateName=ml-datadeft-dev,Version=1 --instance-market-options MarketType=spot --security-group-ids "sg-07edf7ce20415dac2" --subnet-id "subnet-0311997500275ee41"
