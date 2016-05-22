FROM ubuntu:14.04.4
MAINTAINER James Kirkby <jkirkby91@gmail.com>

# Set some environment vars
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# add multiverse repos
RUN sudo apt-add-repository multiverse

# install some global stuff
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y build-essential apt-transport-https ca-certificates software-properties-common apparmor-utils libssl-dev nano language-pack-en-base gettext-base curl && \
apt-get autoremove -y && \
apt-get clean && \
apt-get autoclean && \
echo -n > /var/lib/apt/extended_states && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /usr/share/man/?? && \
rm -rf /usr/share/man/??_*

# Set timezone
RUN echo "Europe/London" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata

# set entry point
CMD ["/bin/bash"]
