require 'rails_helper'

RSpec.feature "Creating Articles" do
    
    scenario "- user creates an article" do
       
       visit '/'
       
       click_on 'New Article'
       
       expect(page).to have_content('Create New Article')
       
       fill_in 'Title', with: 'First Article'
       fill_in 'Body', with: 'Lorem ipsum sit dolor amet'
       
       click_button 'Create Article'
       
       expect(page).to have_content('Article was created successfully')
       expect(page.current_path).to eq(articles_path)
        
    end
    
    scenario "- user fails to creates an article" do
       
       visit '/'
       
       click_on 'New Article'
       
       expect(page).to have_content('Create New Article')
       
       fill_in 'Title', with: ''
       fill_in 'Body', with: ''
       
       click_button 'Create Article'
       
       expect(page).to have_content('Article has not been created')
       expect(page).to have_content("Title can't be blank")
       expect(page).to have_content("Body can't be blank")
       #expect(page.current_path).to eq(new_article_path)
        
    end
    
end