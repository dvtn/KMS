$ cd /opt
$ mkdir jdk1.8
$ cd jdk1.8
$ cp jdk-8u202-linux-x64.tar.gz ./jdk1.8


FROM rockylinux:9.2
LABEL wx.centific.author="david.tian@live.com" wx.centific.createtime="2023-07-11"
ADD jdk-8u202-linux-x64.tar.gz /usr/local
ENV JAVA_HOME /usr/local/jdk1.8.0_202
ENV JRE_HOME /usr/local/jdk1.8.0_202/jre
ENV PATH $JAVA_HOME/bin:$PATH 


docker build -t rockylinux-jdk1.8:v1 .