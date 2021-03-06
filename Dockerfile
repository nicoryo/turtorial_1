FROM ruby:2.6.3
# RUN apt-get update -qq && apt-get install -y build-essetial libpq-dev nodejs postgresql-client
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                            libpq-dev \
                            nodejs \
                            postgresql-client
RUN mkdir /my_app
WORKDIR /my_app
COPY Gemfile /my_app/Gemfile
COPY Gemfile.lock /my_app/Gemfile.lock
RUN bundle install
COPY . /my_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
