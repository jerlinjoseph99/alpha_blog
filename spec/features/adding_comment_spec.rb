require 'rails_helper'

RSpec.feature "Adding Comments" do
    
    before do
        @johndoe = User.create(:email =>"johndoe@gmail.com", :password => "password@123")
        @fred = User.create(:email =>"fred@gmail.com", :password => "password@123")
        @article = Article.create!(title: "Title one", body: "Body of article one", user: @johndoe)
        login_as(@johndoe)  #uses Warden
    end
    
    scenario "- signed in user adds a comment" do
       
       visit '/'
       
       click_on @article.title
       
       expect(page).to have_content('Body of article one')
       
       fill_in 'Add a comment', with: 'An amazing Article'
       
       click_button 'Add Comment'
       
       expect(page).to have_content('Comment was added successfully')
       expect(page.current_path).to eq(article_path(@article))
       expect(page).to have_content("An amazing Article")
        
    end
    
   
end