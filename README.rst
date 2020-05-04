Overview
--------
This is my repo for building, and running goestools in a docker container.
This container runs goestools in a network recvieve mode to process images
from the GOES satellites.   The goesproc app is running on a raspi to 
recieve the signals via rtlsdr.  

The ci directory is used for concourse related pipeline builds.
The docker directory is for running the container.
