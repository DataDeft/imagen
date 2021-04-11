alias awsc='aws --profile datadeft-dev --region eu-central-1'

awsc iam create-policy --policy-name "dev-ml-datadeft-policy" --path "/dev/" --policy-document "file://dev.ml.datadeft.policy.json"


{
    "Policy": {
        "PolicyName": "dev-ml-datadeft-policy",
        "PolicyId": "ANPAZPRBSW3WWSRVNAECR",
        "Arn": "arn:aws:iam::651831719661:policy/dev/dev-ml-datadeft-policy",
        "Path": "/dev/",
        "DefaultVersionId": "v1",
        "AttachmentCount": 0,
        "PermissionsBoundaryUsageCount": 0,
        "IsAttachable": true,
        "CreateDate": "2021-04-11T13:44:01+00:00",
        "UpdateDate": "2021-04-11T13:44:01+00:00"
    }
}


awsc iam create-role --role-name dev-ml-datadeft-role --path "/dev/" --assume-role-policy-document "file://dev.ml.datadeft.assume-role.policy.json"


{
    "Role": {
        "Path": "/dev/",
        "RoleName": "dev-ml-datadeft-role",
        "RoleId": "AROAZPRBSW3WUAP2AGUEG",
        "Arn": "arn:aws:iam::651831719661:role/dev/dev-ml-datadeft-role",
        "CreateDate": "2021-04-11T13:44:34+00:00",
        "AssumeRolePolicyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": [
                            "ec2.amazonaws.com"
                        ]
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        }
    }
}


awsc iam attach-role-policy --role-name dev-ml-datadeft-role  --policy-arn "arn:aws:iam::651831719661:policy/dev/dev-ml-datadeft-policy"

0

awsc iam create-instance-profile --instance-profile-name dev-ml-datadeft-instance-profile --path /dev/hu/

{
    "InstanceProfile": {
        "Path": "/dev/hu/",
        "InstanceProfileName": "dev-ml-datadeft-instance-profile",
        "InstanceProfileId": "AIPAZPRBSW3W72KUXE7OK",
        "Arn": "arn:aws:iam::651831719661:instance-profile/dev/hu/dev-ml-datadeft-instance-profile",
        "CreateDate": "2021-04-11T13:47:31+00:00",
        "Roles": []
    }
}


awsc iam add-role-to-instance-profile  --instance-profile-name dev-ml-datadeft-instance-profile --role-name dev-ml-datadeft-role

0

awsc ec2 associate-iam-instance-profile --iam-instance-profile Name=dev-ml-datadeft-instance-profile --instance-id i-062717deca806eb0e

{
    "IamInstanceProfileAssociation": {
        "AssociationId": "iip-assoc-03c977421cd83eb09",
        "InstanceId": "i-062717deca806eb0e",
        "IamInstanceProfile": {
            "Arn": "arn:aws:iam::651831719661:instance-profile/dev/hu/dev-ml-datadeft-instance-profile",
            "Id": "AIPAZPRBSW3W72KUXE7OK"
        },
        "State": "associating"
    }
}
