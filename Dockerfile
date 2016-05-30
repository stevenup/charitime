FROM phusion/passenger-ruby22

# === 1 ===

# Prepare for packages
RUN apt-get update --assume-yes && apt-get install --assume-yes build-essential

# For a JS runtime
# http://nodejs.org/
RUN apt-get install --assume-yes nodejs
RUN apt-get update -qq && apt-get install -y build-essential

# For Nokogiri gem
# http://www.nokogiri.org/tutorials/installing_nokogiri.html#ubuntu___debian
RUN apt-get install --assume-yes libxml2-dev libxslt1-dev

# timezone
RUN echo "Asia/Chongqing" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# === 2 ===

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production
ENV SECRET_KEY_BASE "7c312e4732367b94b9838a1261d3ae1a864e9b034264afeee7eeeffbb9123a1ac9791c337be81e7734015e27d98cf6fe5a843f459cb81295f9af39a42038f08e"

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# === 3 ===

# By default Nginx clears all environment variables (except TZ). Tell Nginx to
# preserve these variables. See nginx-env.conf.
COPY docker/nginx-env.conf /etc/nginx/main.d/rails-env.conf

# Start nginx and passenger
RUN rm -f /etc/service/nginx/down
EXPOSE 80

# === 4 ===

# Our application should be placed inside /home/app. The image has an app user
# with UID 9999 and home directory /home/app. Our application is supposed to run
# as this user. Even though Docker itself provides some isolation from the host
# OS, running applications without root privileges is good security practice.
WORKDIR /home/app

# Run Bundle in a cache efficient way. Before copying the whole app, copy just
# the Gemfile and Gemfile.lock into the tmp directory and ran bundle install
# from there. If neither file changed, both instructions are cached. Because
# they are cached, subsequent commands??like the bundle install one??remain
# eligible for using the cache. Why? How? See ...
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
COPY Gemfile /home/app/
COPY Gemfile.lock /home/app/
RUN bundle install --deployment --without test development doc


# === 5 ===
COPY . /home/app
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
RUN chown -R app:app /home/app

RUN rm /etc/nginx/sites-enabled/default
ADD docker/nginx-charitime-app.conf /etc/nginx/sites-enabled/charitime-app.conf
