FROM registry.gitlab.com/couchbits/movestore/movestore-groundcontrol/co-pilot-v1-r:geospatial-4.1.2-2809

# install system dependencies required by this app

WORKDIR /root/app

# install the R dependencies this app needs
# RUN R -e 'remotes::install_version("move")'
# RUN R -e 'remotes::install_version("sp")'
# RUN R -e 'remotes::install_version("sf")'
# RUN R -e 'remotes::install_version("ggplot2")'
# RUN R -e 'remotes::install_version("adehabitatLT")'
# RUN R -e 'remotes::install_version("geosphere")'

# copy the app as late as possible
# therefore following builds can use the docker cache of the R dependency installations
COPY RFunction.R .
COPY GRIP_roads_NASAY2Y/* GRIP_roads_NASAY2Y

# take a snapshot of all R dependencies
RUN R -e 'renv::snapshot()'