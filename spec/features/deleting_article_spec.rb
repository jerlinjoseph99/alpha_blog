require 'rails_helper'

RSpec.feature "Deleteting Articles" do
    
     before do
        
        @johndoe = User.create(:email =>"johndoe@gmail.com", :password => "password@123")
        login_as(@johndoe)  #uses Warden
        @article = Article.create(:title =>"Article1", :body => "Lorem ipsum", user: @johndoe)
        
    end
    
     scenario "- user deletes an article successfully" do
       
       visit '/'
       
       click_on @article.title
       
       expect(page).to have_content(@article.title)
       expect(page).to have_content(@article.body)
       
       click_link 'Delete Article'
       
       expect(page).to have_content('Article was deleted successfully')
       expect(page.current_path).to eq(articles_path)
       
       expect(page).not_to have_content(@article.title)
       expect(page).not_to have_content(@article.body)
        
    end
    
end