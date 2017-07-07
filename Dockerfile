FROM ruby:2.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# for capybara-webkit
RUN apt-get install -y libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb libqt4-webkit libqt4-dev

RUN mkdir /ewc
WORKDIR /ewc
ADD Gemfile /ewc/Gemfile
ADD Gemfile.lock /ewc/Gemfile.lock
RUN bundle install
ADD . /ewc
