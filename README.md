ml_environment
====
## Overview  
Scripts and templates for launching the Kaggle notebook environment

## Usage
1. Clone ml_environment on your machine.  
`git clone https://github.com/tattaka/ml_environment.git`

2. Put project directory in repository.  
`mv /your/project_A ml_environment/projects/`  
or  
`cp /your/project_A ml_environment/projects/`

3. Run Docker Container.   
`cd ml_environment`  
`./RUN-KAGGLE-{CPU or GPU}-ENV.sh`  
The images is downloaded automatically from [gcr.io/kaggle-images/python](https://console.cloud.google.com/gcr/images/kaggle-images/GLOBAL/python) or [gcr.io/kaggle-gpu-images/python](https://console.cloud.google.com/gcr/images/kaggle-gpu-images/GLOBAL/python).  
