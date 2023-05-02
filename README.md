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

###### Create travis.yml with related configuration from elastic beanstalk

```
sudo: required
language: node_js
node_js:
  - 16
services:
  - docker
before_install:
  - docker build -t jason8746/node:1.0 -f Dockerfile.dev .
script:
  - docker run -e CI=true jason8746/node:1.0 npm run test -- --coverage --watchAll=false

deploy:
  provider: elasticbeanstalk
  region: "ap-southeast-2"
  app: "react-app-travis" ### Your EB App name
  env: "React-app-travis-env-1" ### Your EB App environment name
  bucket_name: "elasticbeanstalk-ap-southeast-2-044530424430" ### S3 bucket name
  bucket_path: "travis-ela" ### S3 folder name under S3 bucket above
  on:
    branch: master
  access_key_id: "$AWS_ACCESS_KEY"
  secret_access_key: "$AWS_SECRET_KEY"
```

###### Commit the code into github repo

###### Add the repo into travis

###### configure the env variables needed in the travis.yml to assign travis get access to elastic beanstalk and ec2

![iamge](images//Screenshot%202023-05-02%20at%2011.41.23%20am.png)

###### Trigger build in Travis

![iamge](images/Screenshot%202023-05-02%20at%2011.16.55%20am.png)
