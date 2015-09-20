Docker container for Apache and PHP FPM
=======================================


Sample Docker container for running Apache and PHP FPM using supervisor.

To build the image

  docker build -t mocdk/apachephp .

To run

 docker run -p 22 -p 80:80 -d mocdk/apachephp

The image exposes port 22 and port 80