require "spec_helper"

describe WatcherMailer do
  it 'has the right subject' do
    @watcher = Watcher.new(:email => 'a@b.com')
    WatcherMailer.new_watcher(@watcher).subject.should == "I'll keep you posted :)"
  end
end
