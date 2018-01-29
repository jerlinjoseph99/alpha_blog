require 'rails_helper'

RSpec.feature "Editing Articles" do
    
    before do
        
        @article1 = Article.create(:title =>"Article1", :body => "Lorem ipsum")
        
    end
    
    scenario "- user edits an article" do
       
       visit '/'
       
       click_on @article1.title
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       click_on 'Edit Article'
       
       expect(page).to have_content('Edit Article')
       
       fill_in 'Title', with: 'First Article'
       fill_in 'Body', with: 'Lorem ipsum sit dolor amet'
       
       click_button 'Update Article'
       
       expect(page).to have_content('Article was updated successfully')
       expect(page.current_path).to eq(articles_path)
        
    end
    
    scenario "- user updates an article unsuccessfully" do
       
       visit '/'
       
       click_on @article1.title
       
       expect(page).to have_content(@article1.title)
       expect(page).to have_content(@article1.body)
       
       click_on 'Edit Article'
       
       expect(page).to have_content('Edit Article')
       
       fill_in 'Title', with: ''
       fill_in 'Body', with: ''
       
       click_button 'Update Article'
       
       expect(page).to have_content('Article has not been updated')
       #expect(page.current_path).to eq(articles_path)
        
    end
    
    
    
end