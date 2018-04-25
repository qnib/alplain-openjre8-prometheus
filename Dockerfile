ARG DOCKER_REGISTRY=docker.io
ARG DOCKER_IMG_TAG=":2018-04-25_7df6db5aa61a"
ARG DOCKER_IMG_HASH="@sha256:38ee7b4dc93b6df93ea5ed6c2019e5912324a596d08b957bab3f1b99a8ecbd16"
FROM ${DOCKER_REGISTRY}/qnib/alplain-openjre8-glibc${DOCKER_IMG_TAG}${DOCKER_IMG_HASH}

ARG PROM_JMX_AGENT_VER=0.3.0
ARG PROM_JMX_AGENT_URL=https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent

LABEL prometheus.jmx.agent.version=${PROM_JMX_AGENT_VER}
ENV PROMETHEUS_PORT=7071 \
    JMX_PORT=1234 \
    ENTRYPOINTS_DIR=/opt/qnib/entry \
    PROMETHEUS_JMX_PROFILE=default
RUN apk --no-cache add curl bc wget \
 && mkdir -p /opt/prometheus/jmx \
 && wget -qO /opt/prometheus/jmx/prometheus_javaagent.jar ${PROM_JMX_AGENT_URL}/${PROM_JMX_AGENT_VER}/jmx_prometheus_javaagent-${PROM_JMX_AGENT_VER}.jar \
 && apk --no-cache del curl wget
COPY opt/qnib/entry/*.sh \
     opt/qnib/entry/*.env \
     /opt/qnib/entry/
COPY opt/prometheus/jmx/default.yml /opt/prometheus/jmx/
