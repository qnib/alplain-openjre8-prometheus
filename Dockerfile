ARG DOCKER_REGISTRY=docker.io
FROM ${DOCKER_REGISTRY}/qnib/alplain-openjre8

ARG PROM_JMX_AGENT_VER=0.10
ARG PROM_JMX_AGENT_URL=https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent
LABEL prometheus.jmx.agent.version=${PROM_JMX_AGENT_VER}
ENV PROMETHEUS_PORT=7071 \
    JMX_PORT=1234 \
    ENTRYPOINTS_DIR=/opt/qnib/entry
RUN apk --no-cache add curl bc wget \
 && mkdir -p /opt/prometheus/jmx \
 && wget -qO /opt/prometheus/jmx/prometheus_javaagent.jar ${PROM_JMX_AGENT_URL}/${PROM_JMX_AGENT_VER}/jmx_prometheus_javaagent-${PROM_JMX_AGENT_VER}.jar \
 && apk --no-cache del curl wget
COPY opt/qnib/entry/*.sh \
     opt/qnib/entry/*.env \
     /opt/qnib/entry/
