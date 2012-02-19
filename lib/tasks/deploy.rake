task :shipit => ['deploy:push', 'deploy:restart', 'deploy:tag']
task :shipit_with_migrations => ['deploy:push', 'deploy:off', 'deploy:migrate', 'deploy:restart', 'deploy:on', 'deploy:tag']
namespace :deploy do

  task :push do
    puts 'Deploying site to Heroku ...'
    puts `git push heroku master --force`
  end
  
  task :restart do
    puts 'Restarting app servers ...'
    puts `heroku restart`
  end
  
  task :tag do
    release_name = "release-#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
    puts "Tagging release as '#{release_name}'"
    puts `git tag -a #{release_name} -m 'Tagged release'`
    puts `git push --tags heroku`
  end
  
  task :migrate do
    puts 'Running database migrations ...'
    puts `heroku run rake db:migrate`
  end
  
  task :off do
    puts 'Putting the app into maintenance mode ...'
    puts `heroku maintenance:on`
  end
  
  task :on do
    puts 'Taking the app out of maintenance mode ...'
    puts `heroku maintenance:off`
  end

end