FROM developmentseed/geolambda:min

RUN \
  yum -y update; \
  # gippy dependencies
  yum install -y libgdal-dev python-setuptools g++ python-dev swig; \
  # python 3.5
  yum install -y python36-devel python36-pip; \
  pip-3.6 install setuptools boto3 nose numpy; \
  # python 2.7
  yum install -y python27-devel python27-pip; \
  pip-2.7 install setuptools boto3 nose numpy; \
  yum clean all;

ENV \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

ADD . /code
WORKDIR /code
RUN git clone http://github.com/gipit/gippy.git
WORKDIR /code/gippy
RUN pip-2.7 install -e .
RUN pip-3.6 install -e .
WORKDIR /code
RUN pip-3.6 install -r requirements.txt

ENTRYPOINT [ "./cumulus-ecs-task" ]
