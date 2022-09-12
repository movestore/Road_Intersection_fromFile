FROM registry.gitlab.com/couchbits/movestore/movestore-groundcontrol/co-pilot-v1-r:geospatial-4.1.2-2938

# install system dependencies required by this app

WORKDIR /home/moveapps/co-pilot-r

# install the R dependencies this app needs
RUN R -e 'remotes::install_version("move")'
RUN R -e 'remotes::install_version("sp")'
RUN R -e 'remotes::install_version("sf")'
RUN R -e 'remotes::install_version("ggplot2")'
RUN R -e 'remotes::install_version("adehabitatLT")'
RUN R -e 'remotes::install_version("geosphere")'

# take a snapshot of all R dependencies
RUN R -e 'renv::snapshot()'

# copy the app as late as possible
# therefore following builds can use the docker cache of the R dependency installations
COPY --chown=moveapps:staff RFunction.R .
COPY --chown=moveapps:staff provided-app-files/GRIP_roads_NASAY2Y/ provided-app-files/GRIP_roads_NASAY2Y/
