FROM hasholding/alpine-base

LABEL maintainer "Levent SAGIROGLU <LSagiroglu@gmail.com>"

ARG VERSION=1.1.1

RUN apk add --no-cache \
        ruby ruby-irb ruby-json ruby-bigdecimal \
 && apk add --no-cache --virtual .build-deps \
        ruby-dev  build-base  wget gnupg zlib-dev libxml2-dev  \
 && echo 'gem: --no-document' >> /etc/gemrc \
 && gem install oj -v 3.3.10 \
 && gem install json -v 2.1.0 \
 && gem install zlib -v 1.0.0 \
 && gem install -V fluentd-ui \
 && fluent-gem install fluent-plugin-influxdb \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

EXPOSE 80 9292 9880 24220 24224 24230 

ENTRYPOINT ["/usr/bin/fluentd-ui", "start"]
