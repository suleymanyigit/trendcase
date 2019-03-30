#fetch rhel7 base image from access.redhat
#FROM registry.access.redhat.com/rhel7/rhel
FROM centos:7 
MAINTAINER Suleyman&YigitCan 

#Install wget & tar
RUN yum -y update && \
 yum -y install wget && \
 yum -y install unzip && \
 yum -y install telnet

#Prepare Oracle Java 8 Installation
ARG ORACLE_JDK_VERSION=8u201
ARG ORACLE_JDK_BUILD_NUMBER=b09
ARG ORACLE_JDK_DOWNLOAD_KEY=42970487e3af4f5aa5bca3f542482c60

#Install Oracle Java 8
RUN curl -vfL -H "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jdk-${ORACLE_JDK_VERSION}-linux-x64.rpm http://download.oracle.com/otn-pub/java/jdk/${ORACLE_JDK_VERSION}-${ORACLE_JDK_BUILD_NUMBER}/${ORACLE_JDK_DOWNLOAD_KEY}/jdk-${ORACLE_JDK_VERSION}-linux-x64.rpm && \
 rpm -ivh /tmp/jdk-${ORACLE_JDK_VERSION}-linux-x64.rpm && \
 rm -f /tmp/*;


# Install Oracle Unlimited un Policy
RUN curl -o /tmp/jce_policy-8.zip -H "Cookie:oraclelicense=accept-securebackup-cookie" -L -v http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
 unzip -d /tmp /tmp/jce_policy-8.zip && \
 /bin/cp -rf /tmp/UnlimitedJCEPolicyJDK8/*.jar /usr/java/latest/jre/lib/security;



EXPOSE 8080
