FROM coolbeevip/alpine-jre:8

MAINTAINER coolbeevip <coolbeevip@gmail.com>

ENV ZOOKEEPER_VERSION 3.4.14
ENV ZK_HOME /opt/zookeeper

#Download Zookeeper
RUN mkdir -p ${ZK_HOME} && \
    wget -q http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
    tar -xzf zookeeper-${ZOOKEEPER_VERSION}.tar.gz -C /opt && \
    mv /opt/zookeeper-${ZOOKEEPER_VERSION} /opt/zookeeper && \
    mv /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \
    sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg && \
    mkdir $ZK_HOME/data && \
    rm -rf zookeeper-${ZOOKEEPER_VERSION}.tar.gz

ADD start-zk.sh /usr/bin/start-zk.sh
EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper
VOLUME ["/opt/zookeeper/conf", "/opt/zookeeper/data"]

CMD ["bash","/usr/bin/start-zk.sh"]
