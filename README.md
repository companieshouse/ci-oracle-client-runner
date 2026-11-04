# ci-oracle-client-runner
A container for oracle instant client tools for running within Concourse.\
This is based on the official oracle linux version 7 image with version 21 of the instant client tools.

Oracle client component packages are documented [here](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html).
Oracle container image details can be found [here](https://github.com/oracle/docker-images/blob/main/OracleInstantClient/README.md).

## Prerequisites

### Software

The scripts have been developed and tested using:

- [Docker](https://www.docker.com/) (18.03.1)

## Build context

The image build does not download anything from S3. Concourse fetches the required packages from S3 and copies them into a `packages/` directory in the build context before the image is built.

The following files must be present in `packages/`:

- `jdk-8u152-linux-x64.rpm`
- `apache-ant-1.9.13-bin.zip`
- `ivy-2.3.0.jar`
- `sonarqube-ant-task-2.7.0.1612.jar`

## Building the image

To build locally, download the packages from S3 into a `packages/` directory at the root of this repository. You need AWS credentials with read access to the development resources bucket, for example:

```sh
aws sso login --profile development-eu-west-2
export AWS_PROFILE=development-eu-west-2
```

Then download the packages:

```sh
mkdir -p packages
aws s3 cp s3://resources.ch.gov.uk/jdk-8u152-linux-x64.rpm packages/
aws s3 cp s3://resources.ch.gov.uk/apache-ant-1.9.13-bin.zip packages/
aws s3 cp s3://resources.ch.gov.uk/ivy-2.3.0.jar packages/
aws s3 cp s3://resources.ch.gov.uk/packages/sonar/sonarqube-ant-task-2.7.0.1612.jar packages/
```

Build the image:

```sh
docker build -t ci-oracle-client-runner .
```

The `packages/` directory is in `.gitignore`. Do not commit the downloaded files.

## Running the image

If you would like to run and connect to the image, you can do so by running the following:

```sh
docker run -it --rm ci-oracle-client-runner bash
```

## Building the source-code

To mount a project into the container you can run the following:

```sh
# populate the placeholders below
docker run -it --rm -v /Users/username/<path_to_repo>/<repo_name>:/<path_to_source-code> ci-oracle-client-runner bash
```

In most cases to be able to build the source-code for a given library or service you may require extra environment variables which can differ depending on the library or service you want to build.

If you are solely testing the image and you are going to terminate the container directly after use, then you can export the environment variables whilst logged onto the container.

**For any other use case other than testing, precaution MUST be taken to avoid compromising credentials or sensitive data.**
