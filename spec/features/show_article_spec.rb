require 'rails_helper'

RSpec.feature "Showing Article" do
    
    before do
        
        @owner = User.create(:email =>"johndoe@gmail.com", :password => "password@123")
        @nonowner = User.create(:email =>"fred@gmail.com", :password => "password@123")
       
        @article1 = Article.create(:title =>"Article1", :body => "Lorem ipsum", user: @owner)
        
    end
    
    scenario "user views the article without signing in" do
       
       
       visit '/'
       
       click_on @article1.title
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       expect(page).not_to have_link('Edit Article')
       expect(page).not_to have_link('Delete Article')
       
        
    end
    
    scenario "non owner signs in and views the article" do
       
       login_as(@nonowner)  #uses Warden
       visit '/'
       
       click_on @article1.title
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       expect(page).not_to have_link('Edit Article')
       expect(page).not_to have_link('Delete Article')
       
        
    end
    
    scenario "owner views an article after login" do
        
       login_as(@owner)  #uses Warden
       visit '/'
       
       click_on @article1.title
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       expect(page).to have_link('Edit Article')
       expect(page).to have_link('Delete Article')
       
        
    end
end