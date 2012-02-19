require 'spec_helper'

describe HomeController do
  
  describe '#index' do
    before do
      get :index
    end
    
    it 'succeeds' do 
      response.should be_success
    end
      
   
    it 'renders the index layout' do
      response.should render_template('index')
    end
  end
end
