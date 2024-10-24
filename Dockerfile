# Menggunakan base image yang ringan dan mendukung JDK 17
FROM openjdk:17-slim

# Install tools dasar dan Kaniko
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    gnupg2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Kaniko (kaniko executor)
ENV KANIKO_VERSION=v1.13.0
ADD https://github.com/GoogleContainerTools/kaniko/releases/download/${KANIKO_VERSION}/executor /kaniko/executor
RUN chmod +x /kaniko/executor

# Set environment variable untuk Kaniko (agar tidak meminta akses root)
ENV DOCKER_CONFIG=/kaniko/.docker/

# # Membuat direktori kerja
# WORKDIR /home/jenkins/agent

# # Menambahkan user non-root untuk keamanan
# RUN adduser --disabled-password --gecos "" jenkins && chown -R jenkins:jenkins /home/jenkins
# USER jenkins

# Set entrypoint untuk Kaniko
# ENTRYPOINT ["/kaniko/executor"]

# Default command untuk menjalankan Kaniko
CMD ["/kaniko/executor"]
