FROM centos
LABEL maintainer "Angelillou <amalcaraz89@gmail.com>"

ENV PACKAGE "NULS_Wallet_linux64_v2.0.0.tar.gz"
ENV URL="http://nuls-usa-west.oss-us-west-1.aliyuncs.com/2.0/${PACKAGE}"
ENV PACKAGE_FOLDER "NULS_Wallet"

RUN curl ${URL} --output ./${PACKAGE}

RUN ls -la .
RUN tar -xvf ./${PACKAGE} \
    && mv ${PACKAGE_FOLDER} /nuls \
    && rm -f ${PACKAGE} \
    && echo "tail -f /dev/null" >> /nuls/start

WORKDIR /nuls

COPY .modules /nuls/.modules
COPY nuls.ncf /nuls/nuls.ncf

VOLUME /nuls/data /nuls/logs

EXPOSE 8001
EXPOSE 8002
EXPOSE 8003

CMD ["./start"]

RUN echo "successfully build nuls image"
