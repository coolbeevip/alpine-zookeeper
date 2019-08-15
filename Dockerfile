FROM openjdk:8-jre-alpine

MAINTAINER coolbeevip <coolbeevip@gmail.com>

ENV ZOOKEEPER_VERSION 3.4.14
ENV ZK_HOME /opt/zookeeper-${ZOOKEEPER_VERSION}

#Download Zookeeper
RUN mkdir -p ${ZK_HOME} && \
    wget -q http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
    tar -xzf zookeeper-${ZOOKEEPER_VERSION}.tar.gz -C /opt && \
    mv /opt/zookeeper-${ZOOKEEPER_VERSION}/conf/zoo_sample.cfg /opt/zookeeper-${ZOOKEEPER_VERSION}/conf/zoo.cfg && \
    sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg && \
    mkdir $ZK_HOME/data

ADD start-zk.sh /usr/bin/start-zk.sh 
EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper-${ZOOKEEPER_VERSION}
VOLUME ["/opt/zookeeper-${ZOOKEEPER_VERSION}/conf", "/opt/zookeeper-${ZOOKEEPER_VERSION}/data"]

CMD ["bash","/usr/bin/start-zk.sh"]