FROM ruby:2.6.0

ENV LANG C.UTF-8
RUN apt update
RUN apt install -y vim build-essential less mysql-client
RUN apt -y install fonts-ipafont-gothic fonts-ipafont-mincho fonts-migmix
RUN apt -y install cron

#for node.js environment
RUN apt install -y build-essential libpq-dev
RUN apt install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install -y yarn
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt install nodejs

# bundle install using cache
RUN mkdir /rails_app
WORKDIR /rails_app
ADD Gemfile /rails_app/Gemfile
ADD Gemfile.lock /rails_app/Gemfile.lock

# yarn install
ADD yarn.lock /rails_app/yarn.lock
RUN yarn install --dev

# update bundler
RUN gem update bundler
RUN bundle install 

# for chrome driver
RUN apt-get install -y libnss3-dev

RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime