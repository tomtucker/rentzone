# Rentzone Demo app

This project uses Docker to locally build an image to be pused to Amazon Elastic Container Registry (ECR) to be used with either EC2 or ECS deployments.

## Tools Used
Locally generated key pair
SSH Client installed locally
GitHub
Git
Visual Studio Code
Docker Hub
Docker
AWS Account
AWS CLI

## AWS Resources & Features

VPC
Inernet Gateway
Availability Zones
Public Subnets
Private Subnets
Public Route Table
Main Route Table
Security Groups
Relational Database Service
Route 53

## Prerequisites

* Tools and accounts listed above
* SSH key associated with your account

    >This key will be used for programmatic access so a passphrase is discouraged.

* GitHub personal access token
* Web application
    >THis repo includes a sample web application derived from Fleetcart that requires an accompanying datsabase to function.

## Steps

1. Identify sensitive data that should not be commited to GitHub nor exposed in the Docker image.

2. Create Dockerfile using build argument syntax to receive sensitive data. See `Dockerfile`.

3. <a name="step3"></a>Create shell script to pass build arguments to `docker build`. See `build_image.sh` for Linux/Mac or `build_image.ps1` for Windows.

4. Execute shell script to build image

    ```bash
    chmod +x build_image.sh
    ./build_image.sh
    ```

    >[!IMPORTANT]
    > **Do not commit this shell script to your repository with sensitive data**

5. Install and configure [AWS CLI](https://aws.amazon.com/cli/) if necessary.

6. <a name="step6"></a>Create Repositiory in AWS ECR

    ```bash
    aws ecr create-repository --repository-name <repository-name> --region <region>
    ```

    >[!IMPORTANT]
    >Replace `<repository-name>` and `<region>` with the desired name for the ECR repository and the AWS Region for the repositiry, respectively.

7. Retag the image

    ```bash
    docker tag <image-tag> <repository-uri>
    ```

    >[!IMPORTANT]
    >Replace `<image-tag>` with the local Docker tag specified with the `-t` option in the `docker build` script in [Step 3](#step3).

    >[!IMPORTANT]
    >Replace `<repository-uri>` with the URI of the Amazon ECR Repository created in [Step 6](#step6). The URI can be seen using:
    >
    >```bash
    >aws ecr describe-repositories
    >```

8. <a name="step8"></a>Push image to Amazon Elastic Container Registry (ECR)
    1. Retag local Docker image

        ```bash
        docker tag <image-tag> <repository-uri>
        ```

        >[!IMPORTANT]
        >Replace `<image-tag>` with the local Docker tag specified with the `-t` option in the `docker build` script in [Step 3](#step3).

        >[!IMPORTANT]
        >Replace `<repository-uri>` with the ECR repository name used in [Step 6](#step6).

    2. Login to Amazon ECR

        ```bash
        aws ecr get-login-password | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
        ```

        >[!IMPORTANT]
        >Replace `<aws_account_id>` with your AWS Account number. This can be copied from the AWS Management Console by selecting the profile name in the upper right corner of the page.

        >[!IMPORTANT]
        >Repalce `<region>` with the AWS region specified in [Step 6](#step6)

    3. Push Docker image to ECR repository

    ```bash
    docker push <repository-uri>
    ```
    > Use `<repository-uri>` value from [Step 8](#step8)