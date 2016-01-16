FROM swiftdocker/swift

RUN apt-get update && apt-get install -y libssl-dev
RUN git clone https://github.com/Zewo/libvenice.git && \
    cd libvenice && \
    make && \
    make package && \
    dpkg -i libvenice.deb && \
    cd ..
RUN git clone https://github.com/Zewo/uri_parser.git && \
    cd uri_parser && \
    make && \
    make package && \
    dpkg -i uri_parser.deb && \
    cd ..
RUN git clone https://github.com/Zewo/http_parser.git && \
    cd http_parser && \
    make && \
    make package && \
    dpkg -i http_parser.deb && \
    cd ..

RUN mkdir -p /usr/src/bot
COPY . /usr/src/bot
WORKDIR /usr/src/bot

RUN swift build

CMD [".build/debug/starter-swift-bot"]
