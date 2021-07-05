FROM fedora:latest as build

ENV HPROX_DIST https://github.com/bjin/hprox/archive/refs/heads/master.zip

RUN dnf install -y curl unzip \
&& curl -sSL https://get.haskellstack.org/ | sh \
&& curl -sSL ${HPROX_DIST} -o /tmp/hprox-master.zip \
&& unzip /tmp/hprox-master.zip -d /tmp/ \
&& cd /tmp/hprox-master \
&& stack setup \
&& stack install --local-bin-path /usr/local/bin

FROM fedora:latest
ENV HPROX_PORT 8080
COPY --from=build /usr/local/bin/hprox /usr/local/bin/
EXPOSE ${HPROX_PORT}
WORKDIR /
CMD hprox -p ${HPROX_PORT} ${HPROX_OPTIONS}
