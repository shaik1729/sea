# SEA (SVIT EDU AMP)

The objective of this web application is to provide a space where everything resides.

Application up and running.

Things you may want to cover:

* rbenv version -> 1.2.0
* Ruby version -> 3.0.0
* Rails version -> 6
* node version -> 12.22.9
* npm version -> 8.13.2
* yarn version -> 1.22.5

# setting application

Step 1 : clone the repository

* $ git clone https://github.com/shaik1729/sea.git

step 2 : make sure you have the pre-requirements

* $ sudo apt-get update && sudo apt-get upgrade -y
* $ sudo apt install node-js
* $ sudo apt install yarn
* $ sudo apt install npm
* install rbenv from the link
  * https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04
* $ rbenv install 3.0.0

step 3 : make bundle install

* $ cd sea
* $ bundle install

step 4 : create migrate and seed database

* $ rails db:create db:migrate db:seed

step 5 : installing webpacker

* $ npm install
* $ yarn install
* $ rails webpacker:install
* $ rails webpacker:compile
* $ rails assets:precompile

step 6 : run server

* $ rails s
* visit the url http://localhost:3000

# Assets not loading?

If assets are not loading such as css and js then do the following steps

step 1 : remove the public folder

* $ rm -rf public/packs

step 2 : remove the webpacker

* $ rm -rf bin/webpack*

step 3 : install webpacker

* $ rails webpacker:install

step 4 : compile webpacker

* $ rails webpacker:compile

step 5 : precompile assets

* $ rails assets:precompile

step 6 : run the server

* $ rails s
* visit the url http://localhost:3000

# Assets not loading in production


If assets are not loading getting application.css and active_admin.css missing then follow this steps

step 1 : remove the public folder

* $ rm -rf public/packs

step 2 : remove the webpacker

* $ rm -rf bin/webpack*

step 3 : install webpacker

* $ rails webpacker:install

step 4 : compile webpacker

* $ RAILS_ENV=production rails webpacker:compile

step 6 : run the server

* $ rails s -e production
* visit the url http://localhost:3000
* visit the url http://localhost:3000/admin/login
