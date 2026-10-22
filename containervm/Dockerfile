FROM ubuntu:24.04
ENV container container
ENV DEBIAN_FRONTEND=noninteractive

# Install core system tools and dependencies
RUN apt-get update && \
    apt-get install -y \
    dbus systemd openssh-server software-properties-common \
    net-tools iproute2 iputils-ping curl wget git vim sudo \
    ca-certificates gnupg lsb-release && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up the 'developer' user and add them to the 'docker' group
RUN useradd -m -s /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configure SSH
RUN mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Reset machine IDs for systemd
RUN >/etc/machine-id
RUN >/var/lib/dbus/machine-id
RUN systemctl set-default multi-user.target

# Enable SSH and Docker services to start on boot
RUN systemctl enable ssh

EXPOSE 22
