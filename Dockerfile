FROM jenkins/jenkins:2.263.4-lts

USER root

RUN echo "{\"timeout\":6000000,\"allow_root\": true" >> /root/.bowerrc

RUN echo "{\"timeout\":6000000,\"allow_root\": true}" >> /var/jenkins_home/.bowerrc

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs composer build-essential systemd gettext-base

#RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && usermod -aG docker jenkins && usermod -aG root jenkins && systemctl enable docker && service docker start 
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && systemctl enable docker && service docker start 

RUN npm install -g bower phantomjs gulp yarn natives@1.1.6 angular-sanitize karmajs

RUN curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

RUN mkdir /root/.m2

RUN mkdir /var/jenkins_home/.m2

COPY settings.xml /root/.m2/

COPY settings.xml /var/jenkins_home/.m2/


