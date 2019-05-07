FROM mxcins/backend:v1.0.0

SHELL ["/bin/bash", "-c"]

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
  echo "deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb http://mirrors.aliyun.com/debian-security stretch/updates main" >> /etc/apt/sources.list && \
  echo "deb-src http://mirrors.aliyun.com/debian-security stretch/updates main" >> /etc/apt/sources.list && \
  echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib" >> /etc/apt/sources.list && \
  echo "deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y git curl build-essential libssl-dev libreadline-dev zlib1g-dev

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
  && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc \
  && echo 'eval "$(rbenv init -)"' >> ~/.bashrc \
  && source ~/.bashrc \
  && mkdir -p "$(rbenv root)"/plugins \
  && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build \
  && git clone https://github.com/andorchen/rbenv-china-mirror.git "$(rbenv root)"/plugins/rbenv-china-mirror \
  && rbenv install 2.6.2 \
  && rbenv global 2.6.2 \
  && gem update --system \
  && gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ \
  && bundle config mirror.https://rubygems.org https://gems.ruby-china.com

