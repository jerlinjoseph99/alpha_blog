require 'rails_helper'

RSpec.feature "Listing Articles" do
    
    before do
        
        @johndoe = User.create(:email =>"johndoe@gmail.com", :password => "password@123")
       # login_as(@johndoe)  #uses Warden
        @article = Article.create(:title =>"Article1", :body => "Lorem ipsum", user: @johndoe)
        
        @article1 = Article.create(:title =>"Article1", :body => "Lorem ipsum", user: @johndoe)
        @article2 = Article.create(:title =>"Article2", :body => "Lorem ipsum dolor ", user: @johndoe)
        
    end
    
    scenario "lists all articles with user not signed in" do
       
       visit '/'
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       expect(page).to have_content(@article2.title)
       expect(page).to have_content(@article2.body)
       
       expect(page).to have_link(@article2.title)
       expect(page).to have_link(@article2.title)
       
       expect(page).not_to have_link('New Article')
        
    end
    
     scenario "lists all articles with user signed in" do
    
       login_as(@johndoe)   
       visit '/'
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       expect(page).to have_content(@article2.title)
       expect(page).to have_content(@article2.body)
       
       expect(page).to have_link(@article2.title)
       expect(page).to have_link(@article2.title)
       
       expect(page).to have_link('New Article')
        
    end
    
    scenario "user does not have an article" do
        
       Article.delete_all
       
       visit '/'
       
       
       expect(page).not_to have_content(@article1.title)
       expect(page).not_to have_content(@article1.body)
       
       expect(page).not_to have_content(@article2.title)
       expect(page).not_to have_content(@article2.body)
       
       expect(page).not_to have_link(@article2.title)
       expect(page).not_to have_link(@article2.title)
       
       within("h2") {
         expect(page).to have_content('There are no articles to display')
       
       }
        
    end
    
   
    
end