ml_environment
====
## Overview  
Mobile environment for machine learning.  
It works on docker.  
This repository is that [jupyter_playgound](https://github.com/tattaka/jupyter_playground) cleaned up.

## Dependence  
* docker>=18  
* docker-compose>=1.21.0  
* cuda>=9.0  

## Usage
1. Clone ml_environment on your machine.  
`git clone https://github.com/tattaka/ml_environment.git`

2. Put working directory in repository.  
`mv /your/workspace ml_environment/projects/`  
or  
`cp /your/workspace ml_environment/projects/`

3. Run Docker Container.   
`cd ml_environment`  
`./RUN-DOCKER-CONTAINER.sh image`  
The images is downloaded automatically from [dockerhub](https://hub.docker.com/r/tattaka/ml_environment).  
`image` can be selected from the following.  
    * `base`
      This option also works if nothing is selected for `image`.  
      Based on nvidia's official docker image, it contains frequently used packages such as `anaconda` and `opencv`.  
    
    * `chainer`
      You can use an image with chainer stable version installed based on the above `base` image.  
      It also includes `chainercv`, `chainercv2`, `chainerui`, and `openmpi` required for `chainermn`.  
    
    In the future, there are plans to support tensorflow and pytorch.
