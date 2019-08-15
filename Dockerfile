FROM coolbeevip/alpine-jre:8

MAINTAINER coolbeevip <coolbeevip@gmail.com>

ENV ZOOKEEPER_VERSION 3.4.14
ENV ZK_HOME /opt/zookeeper

RUN mkdir -p ${ZK_HOME} \
  && wget -q "http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz" -O "/tmp/zookeeper.tar.gz" \
  && tar -xzf /tmp/zookeeper.tar.gz -C /opt \
  && mv ${ZK_HOME}/conf/zoo_sample.cfg ${ZK_HOME}/conf/zoo.cfg \
  && sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg \
  && mkdir $ZK_HOME/data

ADD start-zk.sh /usr/bin/start-zk.sh
EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper
VOLUME ["/opt/zookeeper/conf", "/opt/zookeeper/data"]

CMD ["bash","/usr/bin/start-zk.sh"]
