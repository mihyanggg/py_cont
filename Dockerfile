# base 이미지
#FROM ubuntu:16.04
FROM ubuntu:latest

#ENV USER=user1
ENV USER=mimi

# system 시간과 달라서 문제가 되어 시간 맞춰주는 명령 실행 후 실행
RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until

# 기본 환경 설치 명령어
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y openssh-server \ 
                        ssh \
                        python3.10 \
                        python3.10-dev \
                        python3-pip \
                        vim \
                        unzip
#ssh python3.6 python3.6-dev python3-pip vim unzip

WORKDIR /home/${USER}

CMD ["echo", "1234"]

RUN rm -rf /var/lib/apt/lists/*
#RUN ln -sfn /usr/bin/python3.10 /usr/bin/python3 && ln -sfn /usr/bin/python3 /usr/bin/python && ln -sfn /usr/bin/pip3.10 /usr/bin/pip3 && ln -sfn /usr/bin/pip3 /usr/bin/pip
RUN ln -sfn /usr/bin/python3.10 /usr/bin/python3 && \
    ln -sfn /usr/bin/python3 /usr/bin/python && \
    ln -sfn /usr/bin/pip3.10 /usr/bin/pip3 && \
    ln -sfn /usr/bin/pip3 /usr/bin/pip

# pip 업데이트 및 파이썬 라이브러리 설치 명령어
RUN pip install --upgrade pip \
    && pip install -U setuptools-scm \
                        pymysql \
                        pytz \
                        pysolr \
                        requests \
                        boto3 \
                        awscli \
                        Flask \
    && rm -rf /root/.cache

# 환경 설정
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
#ENV PATH="/var/task:${PATH}"
ENV PATH="/home/${USER}:${PATH}"

# 개발 소스 폴더 copy 
#COPY task /var/task
#WORKDIR /var/task
COPY . /home/${USER}
WORKDIR /home/${USER}

# 실행 명령어
# CMD [ "python", "./run.py" ]
