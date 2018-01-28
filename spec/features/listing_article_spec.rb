require 'rails_helper'

RSpec.feature "Listing Articles" do
    
    before do
        
        @article1 = Article.create(:title =>"Article1", :body => "Lorem ipsum")
        @article2 = Article.create(:title =>"Article2", :body => "Lorem ipsum dolor ")
        
    end
    
    scenario "user lists all articles" do
       
       visit '/'
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       expect(page).to have_content(@article2.title)
       expect(page).to have_content(@article2.body)
       
       expect(page).to have_link(@article2.title)
       expect(page).to have_link(@article2.title)
        
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