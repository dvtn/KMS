# 镜像源
FROM centos:7

# 添加元数据  
LABEL author="mzdrzzrsw" date="2022/03/05"

# 安装openssh-server和sudo软件包，并且将sshd的UsePAM参数设置成no
RUN yum install -y openssh-server sudo
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 安装openssh-clients
RUN yum install -y openssh-clients

# 安装which
RUN yum install -y which

# 添加测试用户root，密码root，并且将此用户添加到sudoers里
RUN echo "root:root" | chpasswd
RUN echo "root ALL=(ALL) ALL" >> /etc/sudoers
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

# 启动sshd服务并且暴露22端口
RUN mkdir /var/run/sshd
EXPOSE 22

# 拷贝并解压jdk，根据自己的版本修改
ADD jdk-8u321-linux-x64.tar.gz /usr/local/
RUN mv /usr/local/jdk1.8.0_321 /usr/local/jdk1.8
ENV JAVA_HOME /usr/local/jdk1.8
ENV PATH $JAVA_HOME/bin:$PATH

# 拷贝并解压hadoop，根据自己的版本修改
ADD hadoop-3.3.2.tar.gz /usr/local
RUN mv /usr/local/hadoop-3.3.2 /usr/local/hadoop
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $HADOOP_HOME/bin:$PATH

# 设置容器启动命令
CMD ["/usr/sbin/sshd", "-D"]
