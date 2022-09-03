# README #

This repo is an example of a simple serverless python solution being created via terraform.

The solution consist of a main SNS topic called 'serverless-updates' and 3 lambda functions 'uno','dos' and 'tres'.

## Install 

```
cd terraform/
terraform init
terraform plan
terraform deploy
```

## Test

The best way to see the behavior is sending a sns message ot the main topic with the following message atribute:

[Event: Trigger Uno]
