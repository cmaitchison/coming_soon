class WatcherMailer < ActionMailer::Base
  default from: "me@comingsoon.com"
  
  def new_watcher(watcher)
    @watcher = watcher
    mail(:subject => "I'll keep you posted :)", :to => @watcher.email)
  end
end
