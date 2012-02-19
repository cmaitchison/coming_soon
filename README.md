## coming_soon

## What is it?
coming_soon is a basic template to collect emails while your real site is under construction.
There is a landing page where watchers will leave their email details, and a page protected by
basicauth that will give you a .csv of all registered watchers.

## How do i see it in action?
```bash
git clone git@github.com:cmaitchison/coming_soon.git
cd coming_soon
bundle install
heroku create --stack cedar
heroku addons:add sendgrid:starter
rake shipit_with_migrations
```

## OK, now what?
Enter your email address and get an email sent to you.  You'll be customising this.

Navigate to /watchers to get a .csv of every email and IP that has registered.
```
username: admin
password: admin
```


## How do i customise it?
```
change the credentials in config/app_config.yml
change the html in app/views/home/index.html.haml
change the css in app/assets/stylesheets/home.css.sass
change the email 'from' and 'subject' in app/mailers/watcher_mailer.rb
change the email HMTL in app/views/watcher_mailer/new_watcher.html.haml
```

## Other interesting things
The heroku sendgrid add-on is used to send the emails from heroku  

In development, run mailcatcher to see the content of the emails being sent
```ruby
mailcatcher
```
