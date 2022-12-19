# ci-oracle-client-runner
A container for oracle instant client tools for running within Concourse.\
This is based on the official oracle linux version 7 image with version 21 of the instant client tools.

Oracle client component packages are documented [here](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html).
Oracle container image details can be found [here](https://github.com/oracle/docker-images/blob/main/OracleInstantClient/README.md).

## Prerequisites

### Software

The scripts have been developed and tested using:

- [Docker](https://www.docker.com/) (18.03.1)

## AWS Configuration
AWS credentials are supplied via the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and `AWS_SESSION_TOKEN` as build arguments.


Variable               | Description                                                     | Notes                      
---------------------- | --------------------------------------------------------------- | --------------------------
AWS_ACCESS_KEY_ID | A valid Access Key ID to authenticate your AWS requests                        | Can be exported in your local shell or set in your bash profile
AWS_SECRET_ACCESS_KEY    | A valid Secret Access Key to authenticate your AWS requests  | Can be exported in your local shell or set in your bash profile
AWS_SECRET_ACCESS_KEY    | A valid Session Token to authenticate your AWS requests  | Can be exported in your local shell or set in your bash profile 

## Building the image

These credentials will not be stored on the image and is purely for pulling in the required resources for the build image.


```sh
docker build \
--build-arg AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id) \
--build-arg AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key) \
--build-arg AWS_SESSION_TOKEN=$(aws configure get aws_session_token) \
-t ci-oracle-client-runner .
```

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
