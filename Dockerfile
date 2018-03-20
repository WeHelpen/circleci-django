FROM circleci/python:2.7

# Add our additional dependencies
RUN sudo apt-get install libgdal1h gettext
