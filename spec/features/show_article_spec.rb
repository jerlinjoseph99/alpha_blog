require 'rails_helper'

RSpec.feature "Showing Article" do
    
    before do
        
        @article1 = Article.create(:title =>"Article1", :body => "Lorem ipsum")
        
    end
    
    scenario "user views an article" do
       
       visit '/'
       
       click_on @article1.title
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       
        
    end
end