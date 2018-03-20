FROM circleci/python:2.7

# Add (lib)gdal dependency
RUN sudo apt-get install libgdal1h
