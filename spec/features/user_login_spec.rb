require 'rails_helper'

RSpec.feature "User Login" do
    
    before do
        @johndoe = User.create(:email =>"johndoe@gmail.com", :password => "password@123")
    end
    
    scenario "- user login into account successfully" do
       
       visit '/'
       
       click_on 'Sign In'
       
       within('h2') { expect(page).to have_content('Log in') }
       
       fill_in 'Email', with: 'johndoe@gmail.com'
       fill_in 'Password', with: 'password@123'
       
       
       click_button 'Log in'
       
       expect(page).to have_content('Signed in successfully.')
       expect(page).not_to have_link("Sign In") 
       expect(page).not_to have_link("Sign Up")
       expect(page).to have_link('Logout')
       expect(page.current_path).to eq(root_path)
        
    end
    
    scenario "- user login into account successfully" do
       
       visit '/'
       
       click_on 'Sign In'
       
       within('h2') { expect(page).to have_content('Log in') }
       
       fill_in 'Email', with: 'jane@gmail.com'
       fill_in 'Password', with: 'password@123'
       
       
       click_button 'Log in'
       
       expect(page).to have_content('Invalid Email or password')
        
    end
   
    
end