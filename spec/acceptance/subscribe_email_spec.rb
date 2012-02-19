require 'acceptance/acceptance_helper'
feature 'Subscribe to email list', :js => true do

  scenario 'Successful subscription' do
    visit '/'
    fill_in 'email', with: 'don@example.com'
    find_link('Email me')
    click_on 'Email me'
    
    page.should have_content 'Please check your inbox'
    
    "don@example.com".should receive_email(:subject => "I'll keep you posted :)")

    #click_link_in_email "Confirm my subscription", :subject => 'Welcome'
    #page.should have_content 'Subscription confirmed'
  end

end