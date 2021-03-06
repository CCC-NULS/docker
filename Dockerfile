FROM centos
LABEL maintainer "Angelillou <amalcaraz89@gmail.com>"

ENV PACKAGE "NULS_Wallet_linux64_2.6.0.tar.gz"
ENV URL="http://nuls-usa-west.oss-us-west-1.aliyuncs.com/2.6/${PACKAGE}"
ENV PACKAGE_FOLDER "NULS_Wallet_linux64_2.6.0"

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
EXPOSE 8004
EXPOSE 8006

CMD ["./start"]

RUN echo "successfully build nuls image"
