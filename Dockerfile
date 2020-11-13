FROM kalilinux/kali-rolling

# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
# ADD ./sources.list /etc/apt/sources.list

# Install stuff
# ENV DEBIAN_FRONTEND noninteractive
# RUN apt-get update && \
#     apt-get -y install metasploit metasploit-framework

ADD ./init.sh /init.sh
CMD ["/init.sh"]