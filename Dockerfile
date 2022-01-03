FROM debian:bullseye

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Singapore

RUN apt-get update && apt-get install -y gcc qemu-user gdb-multiarch

RUN apt-get install -y git

RUN git clone https://github.com/longld/peda.git /peda

RUN apt-get install -y apache2 libapache2-mod-php

RUN apt-get install -y firefox-esr

RUN apt-get install -y sudo libpci3 libegl1

RUN useradd student && mkhomedir_helper student && echo "student ALL=(root) NOPASSWD: /usr/sbin/apachectl" > /etc/sudoers.d/000-student

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ports.conf /etc/apache2/ports.conf

RUN apt-get install -y xvfb

# have to run firefox for the first time to avoid seeing the privacy notice later
RUN sudo -u student timeout 3 xvfb-run firefox || true

ENTRYPOINT ["/entrypoint"]

