# Run the docker build command
docker build `
--build-arg PERSONAL_ACCESS_TOKEN='<PERSONAL_ACCESS_TOKEN>' `
--build-arg GITHUB_USERNAME='<GITHUB_USERNAME>' `
--build-arg REPOSITORY_NAME='<REPOSITORY_NAME>' `
--build-arg WEB_FILE_ZIP='WEB_FILE_ZIP>' `
--build-arg WEB_FILE_UNZIP='<WEB_FILE_UNZIP>' `
--build-arg DOMAIN_NAME='<DOMAIN_NAME>' `
--build-arg RDS_ENDPOINT='<RDS_ENDPOINT>' `
--build-arg RDS_DB_NAME='<RDS_DB_NAME>' `
--build-arg RDS_MASTER_USERNAME='<RDS_MASTER_USERNAME>' `
--build-arg RDS_DB_PASSWORD='<RDS_DB_PASSWORD>' `
-t <image-tag> .