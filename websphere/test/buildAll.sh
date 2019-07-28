#!/bin/bash

#####################################################################################
#                                                                                   #
#  Script to build and test all websphere-liberty Docker images                     #
#                                                                                   #
#                                                                                   #
#  Usage : buildAll.sh							                                                # 
#                                                                                   #
#####################################################################################
$(wget -q -U jenkins -O /tmp/index.yml https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/wasdev/downloads/wlp/index.yml)
docker pull clefos/java

while read -r imageName buildContextDirectory
do
  if [ $imageName == 'clefos/websphere-liberty:beta' ]
  then
    version=$(sed '22q;d' /tmp/index.yml | cut -d':' -f 1)
    ./build.sh $imageName $buildContextDirectory $version && ./verify.sh $imageName
  else
    version=$(tail -n 5 /tmp/index.yml | cut -d':' -f 1 | cut -d' ' -f 1 | tr -d '\n')
    ./build.sh $imageName $buildContextDirectory $version && ./verify.sh $imageName
  fi
  
  
  if [ $? != 0 ]; then
    echo "Failed at image $imageName - exiting"
    exit 1
  fi
    
done < "images.txt"
