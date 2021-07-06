FROM fedora:latest as build

ENV HPROX_VER 0.1.1
    HPROX_DIST https://github.com/bjin/hprox/archive/refs/tags/v${HPROX_VER}.zip

RUN dnf install -y curl unzip \
&& curl -sSL https://get.haskellstack.org/ | sh \
&& curl -sSL ${HPROX_DIST} -o /tmp/hprox-v${HPROX_VER}.zip \
&& unzip /tmp/hprox-v${HPROX_VER}.zip -d /tmp/ \
&& cd /tmp/hprox-v${HPROX_VER} \
&& echo $SHELL ; stack setup --verbose \
&& stack install --verbose --local-bin-path /usr/local/bin

FROM fedora:latest
ENV HPROX_PORT 8080
COPY --from=build /usr/local/bin/hprox /usr/local/bin/
EXPOSE ${HPROX_PORT}
WORKDIR /
CMD hprox -p ${HPROX_PORT} ${HPROX_OPTIONS}
