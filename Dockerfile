FROM ubuntu:16.04
MAINTAINER Keyur Patel <keyur.patel@einfochips.com>

# Make sure the package repository is up to date & Install some required Packages
RUN apt-get update && apt-get install -y openssh-server python python-pip

# Configure SSH agent
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Standard SSH port
EXPOSE 22

# Start the SSH agent
CMD ["/usr/sbin/sshd", "-D"]
