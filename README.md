## Docker Images of clefOS and SLES15 for s390x

This repository contains the source code of docker images of various development stacks in clefOS and SLES15 for system on Z machines.

The repository is divided into two main parts. clefos and suse. clefos contains source code of all the clefos docker images while suse contains all the SLES15 images.

There is a base image constructor in both of these folders. It is inside a folder called base. This is a bash script that generates a chroot environment and adds repos and packages to it and makes a compressed file of the final environment. We use this compressed file to build base image for s390x. These images, one for clefOS and one for SLES15, then can be used by Dockerfiles to build docker images for development stacks.

These folders also have a Jenkinsfile each. The repo is connected to a Jenkins server hosted on a clefOS VM, via webhook. Whenever master gets modified, pipelines for clefOS and suse get triggered. The suse pipeline is using a Jenkins slave to build it's pipeline, which is hosted on a SLES15 VM. The pipelines are structured in a very  similar way. Jenkinsfile instructs the server on how to build the script. The first step is pulling in the source code. Then build the docker images and push them if needed then finally do a cleanup. The pipeline is scheduled to run on 22nd of every month. This system automatically updates all of the images.