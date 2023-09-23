# Website Image for AWS

This project uses Docker to locally build an image to be pushed to Amazon Elastic Container Registry (ECR) to be used with either EC2 or ECS projects.

This project, by itself, will not result in a functioning web application. It memorializes how to pass sensitive information when building Docker images and how to push an image to Amazon Elastic Container Registry.

## Tools Used

* Bash
* SSH Client
* Git
* Visual Studio Code
* Docker
* AWS CLI

## AWS Resources & Features

* Amazon Elastic Container Registry (ECR)

## Prerequisites

* Tools and accounts listed above
* SSH Key pair
* GitHub Account
* SSH key associated with your GitHub account
* GitHub Personal Access Token

    >This key will be used for programmatic access so a passphrase is discouraged.

* GitHub personal access token
* Web application
    >This repo includes a sample web application derived from Fleetcart that requires an accompanying database to function.

## Steps

1. Identify sensitive data that should not be committed to GitHub nor exposed in the Docker image.

2. Create Dockerfile using build argument syntax to receive sensitive data. See [Dockerfile](Dockerfile).

3. <a name="step3"></a>Create shell script to pass build arguments to `docker build`. See [build_image.sh](build_image.sh) for Linux/Mac or [build_image.ps1](build_image.ps1) for Windows.

    >[!IMPORTANT]
    > **Do not commit the modified version of this shell script to your repository with sensitive data!**

4. Execute modified shell script to build image

    ```bash
    chmod +x build_image.sh
    ./build_image.sh
    ```

5. Install and configure [AWS CLI](https://aws.amazon.com/cli/) if necessary.

    [!NOTE]
    It is recommended to create an IAM user with Programmatic Access to use with AWS CLI.

6. <a name="step6"></a>Create Repository in AWS ECR

    ```bash
    aws ecr create-repository --repository-name <repository-name> --region <region>
    ```

    >[!IMPORTANT]
    >Replace `<repository-name>` and `<region>` with the desired name for the ECR repository and the AWS Region for the  repository, respectively.

7. <a name="step7"></a>Re-tag the image

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

8. <a name="step9"></a>Login to Amazon ECR

    ```bash
    aws ecr get-login-password | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
    ```

    >[!IMPORTANT]
    >Replace `<aws_account_id>` with your AWS Account number. This can be copied from the AWS Management Console by selecting the profile name in the upper right corner of the page.

    >[!IMPORTANT]
    >Replace `<region>` with the AWS region specified in [Step 6](#step6)

9. <a name="step9"></a>Push image to Amazon Elastic Container Registry (ECR)

    ```bash
    docker push <repository-uri>
    ```

    >[!IMPORTANT]
    >Replace `<repository-uri>` with the ECR repository name used in [Step 6](#step6).

10. Push Docker image to ECR repository

    ```bash
    docker push <repository-uri>
    ```

    > Use `<repository-uri>` value from [Step 7](#step7).
