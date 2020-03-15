# Used to test various versions 
FROM rocker/tidyverse:devel

WORKDIR /root
COPY . ./loggit
WORKDIR /root/loggit

CMD ["Rscript", "-e", "devtools::check()"]