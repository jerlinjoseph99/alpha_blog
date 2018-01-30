require 'rails_helper'

RSpec.feature "User Signup" do
    
    scenario "- user signup for an account" do
       
       visit '/'
       
       click_on 'Sign Up'
       
       within('h2') { expect(page).to have_content('Sign up') }
       
       fill_in 'Email', with: 'kelly12345@gmail.com'
       fill_in 'Password', with: 'password@123'
       fill_in 'Password confirmation', with: 'password@123'
       
       click_button 'Sign up'
       
       expect(page).to have_content('Welcome! You have signed up successfully.')
       expect(page.current_path).to eq(root_path)
        
    end
    
    scenario "- user fails to signup" do
       
       visit '/'
       
       click_on 'Sign Up'
       
       within('h2') { expect(page).to have_content('Sign up') }
       
       fill_in 'Email', with: ''
       fill_in 'Password', with: ''
       fill_in 'Password confirmation', with: ''
       
       click_button 'Sign up'
       
       expect(page).to have_content('errors')
        
        
    end
    
   
    
end