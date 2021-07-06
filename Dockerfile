FROM centos:latest as build

ENV HPROX_VER 0.1.1

RUN curl -sSL https://get.haskellstack.org/ | sh \
&& curl -sSL https://github.com/bjin/hprox/archive/refs/tags/v${HPROX_VER}.tar.gz -o /tmp/hprox-${HPROX_VER}.tar.gz \
&& tar xvfz /tmp/hprox-${HPROX_VER}.tar.gz -C /tmp/ \
&& cd /tmp/hprox-${HPROX_VER} \
&& stack setup --verbose \
&& stack install --verbose --local-bin-path /usr/local/bin

FROM centos:latest
ENV HPROX_PORT 8080
COPY --from=build /usr/local/bin/hprox /usr/local/bin/
EXPOSE ${HPROX_PORT}
WORKDIR /
CMD hprox -p ${HPROX_PORT} ${HPROX_OPTIONS}
