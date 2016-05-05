FROM ubuntu:14.04.4
MAINTAINER James Kirkby <jkirkby91@gmail.com>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# install some global stuff
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y software-properties-common libmcrypt-dev mcrypt build-essential curl monit nano curl language-pack-en-base gettext-base git && \
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
