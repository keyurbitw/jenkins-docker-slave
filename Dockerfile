<<<<<<< HEAD
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
=======
FROM ubuntu:14.04
MAINTAINER Bibin Wilson <bibinwilsonn@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git
# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN apt-get install -y openjdk-7-jdk

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

RUN mkdir /home/jenkins/.m2

ADD settings.xml /home/jenkins/.m2/

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ 

RUN apt-get install -y maven
# Standard SSH port
EXPOSE 22

>>>>>>> fb2cc7fe4a8c3b6ca0cd5cb2f2171ce7efe9f0d7
CMD ["/usr/sbin/sshd", "-D"]
