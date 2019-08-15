FROM coolbeevip/alpine-jre:8

MAINTAINER coolbeevip <coolbeevip@gmail.com>

ENV ZOOKEEPER_VERSION 3.4.14
ENV ZK_HOME /opt/zookeeper

RUN mkdir -p ${ZK_HOME} \
  && wget -q http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz -O "/tmp/zookeeper-${ZOOKEEPER_VERSION}.tar.gz" \
  && tar -xzf /tmp/zookeeper-${ZOOKEEPER_VERSION}.tar.gz -C /tmp \
  && cp -r /tmp/zookeeper-${ZOOKEEPER_VERSION}/* ${ZK_HOME} \
  && mv ${ZK_HOME}/conf/zoo_sample.cfg ${ZK_HOME}/conf/zoo.cfg \
  && sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg \
  && mkdir $ZK_HOME/data \
  && rm -rf /tmp/*

ADD start-zk.sh /usr/bin/start-zk.sh

EXPOSE 2181 2888 3888

WORKDIR ${ZK_HOME}
VOLUME ["${ZK_HOME}/conf", "${ZK_HOME}/data"]

CMD ["bash","/usr/bin/start-zk.sh"]
