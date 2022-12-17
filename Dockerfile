FROM alpine:3

ARG USERNAME="apline-user"
ARG USER_GCOS="Alpine User"
ARG PASSWORD
ARG ROOT_PASSWORD
ARG PERMIT_ROOT_LOGIN="no"

RUN apk add openssh
RUN adduser ${USERNAME} --gecos "${USER_GCOS}" --disabled-password
RUN echo "root:${ROOT_PASSWORD}" | chpasswd
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin ${PERMIT_ROOT_LOGIN}/" /etc/ssh/sshd_config
RUN ssh-keygen -A
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]