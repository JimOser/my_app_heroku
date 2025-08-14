# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
https://devcenter.heroku.com/articles/getting-started-with-rails7

 1042  rails new my_app_heroku --skip-javascript
 1043  ls
 1044  cd my_app_heroku
 1045  rails db:create
 1046  ls
 1047  vi Gemfile
 1048  bundle install
 1049  rails db:create
 1050  rails g model Post title:string body:text
 1051  rails db:migrate
 1052  rails s -b 0.0.0.0

 1053  heroku login

 1054  bundle lock --add-platform x86_64-linux --add-platform ruby

 1055  cat Gemfile.lock
 1056  bundle install

 1057  cat config/database.yml

 # Rails 7 no longer has a static index page in production by default. Apps upgraded to Rails 7 keep their existing page configurations, but new Rails 7 apps don’t automatically generate a welcome page. Create a welcome controller to hold the homepage:



 1058  rails generate controller welcome
 1059  vi app/views/welcome/index.html.erb
 1060  vi config/routes.rb
 1061  rails s -b 0.0.0.0
 1062  grep ruby Gemfile
 1063  ruby -v
 1064  vi Procfile
 1065  vi config/puma.rb
 1066  git init
 1067  git add .
 1068  git commit -m "init"
 1069  git status
 1070  heroku apps:create
 1071  git config --list --local
 1072  git push heroku main
 1073  vi README.txt
 1074  ls
 1075  vi README.md
 1076  history >> README.md
 1077  view README.md
