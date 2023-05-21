# DevOps-Deploy-React-App-on-AWS-Elasticbeanstalk-and-Conduct-CI-via-Travis

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode locally.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

### `npm test`

Runs the test locally

### Usage instruction

###### Create react app

###### Create Dockerfile.dev for dev environment

###### Create Dockerfile for pro environment

###### Create a elastic beanstalk in aws with default configuration

###### Create a travis user with least privilege and download the access_key / secret_id

![image](images/Screenshot%202023-05-02%20at%2011.36.51%20am.png)

###### Create a folder inside the s3 bucket created by elastic beanstalk to store build file

#configure the bucket permissions to allow public access and enable ACLs

###### Create cd.yml with related configuration from elastic beanstalk

```
name: Deploy to Elastic Beanstalk

on:
  pull_request:
    types: [closed]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Create ZIP deployment package
        run: zip -r deploy_package.zip ./

      - name: Install AWS CLI
        run: |
          sudo apt-get update
          sudo apt-get install -y python3-pip
          pip3 install --user awscli

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ap-southeast-2

      - name: Upload package to S3 bucket
        run: aws s3 cp deploy_package.zip s3://elasticbeanstalk-ap-southeast-2-044530424430

      - name: Deploy to Elastic Beanstalk
        run: |
          aws elasticbeanstalk create-application-version \
            --application-name react-app \
            --version-label ${{ github.sha }} \
            --source-bundle S3Bucket="elasticbeanstalk-ap-southeast-2-482739392776",S3Key="deploy_package.zip"

          aws elasticbeanstalk update-environment \
            --environment-name React-app-env \
            --version-label ${{ github.sha }}

```

###### Commit the code into github repo

###### Add the repo into travis

###### configure the env variables needed in the travis.yml to assign travis get access to elastic beanstalk and ec2

![iamge](images//Screenshot%202023-05-02%20at%2011.41.23%20am.png)

###### Trigger build in Travis

![iamge](images/Screenshot%202023-05-02%20at%2011.16.55%20am.png)

###### Browser the react app via domain name

```
http://react-app-travis-env-1.eba-bvrtsetk.ap-southeast-2.elasticbeanstalk.com/
```

![image](images/Screenshot%202023-05-02%20at%2011.47.13%20am.png)
