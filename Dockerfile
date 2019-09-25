FROM centos
LABEL maintainer "Angelillou <amalcaraz89@gmail.com>"

ENV PACKAGE "NULS_Wallet_linux64_v2.1.0_beta.tar.gz"
ENV PACKAGE_FOLDER "NULS_Wallet_linux64_v2.1.0_beta"
ENV URL="http://nuls-usa-west.oss-us-west-1.aliyuncs.com/2.1/${PACKAGE}"

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
