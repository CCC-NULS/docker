FROM centos
LABEL maintainer "Angelillou <amalcaraz89@gmail.com>"

ENV PACKAGE "NULS_Wallet_beta3.2-linux.tar.gz"
ENV PACKAGE_FOLDER "NULS_Wallet_beta3.2"
ENV URL="http://nuls-usa-west.oss-us-west-1.aliyuncs.com/beta3.2/${PACKAGE}"

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

EXPOSE 18001
EXPOSE 18002
EXPOSE 18003

CMD ["./start"]

RUN echo "successfully build nuls image"
