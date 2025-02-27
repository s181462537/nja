FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y curl

RUN version=$(basename $(curl -sL -o /dev/null -w %{url_effective} https://github.com/gngpp/ninja/releases/latest)) \
    && base_url="https://github.com/gngpp/ninja/releases/expanded_assets/$version" \
    && latest_url=https://github.com/$(curl -sL $base_url | grep -oP 'href=".*x86_64.*musl\.tar\.gz(?=")' | sed 's/href="//') \
    && curl -Lo ninja.tar.gz $latest_url \
    && tar -xzf ninja.tar.gz


ENV LANG=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive LANGUAGE=en_US.UTF-8 LC_ALL=C

RUN cp ninja /bin/ninja
RUN mkdir /.ninja && chmod 777 /.ninja

RUN rm -rf /root/.ninja

CMD ["/bin/ninja","run", "--arkose-endpoint", "https://nja-fviv.onrender.com", "--enable-webui"]
