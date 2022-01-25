FROM redhat/ubi8
WORKDIR /app
RUN yum install -y python3 && yum clean all
RUN pip3 install py-spy==0.4.0.dev1
CMD [ "/bin/bash" ]
