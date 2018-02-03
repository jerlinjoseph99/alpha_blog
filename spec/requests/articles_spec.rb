require 'rails_helper'

RSpec.describe "Articles", type: :request do
    before do
        @johndoe = User.create(:email =>"johndoe@gmail.com", :password => "password@123")
        @fred = User.create(:email =>"fred@gmail.com", :password => "password@123")
        @article = Article.create!(title: "Title one", body: "Body of article one", user: @johndoe)
    end
    
    describe 'GET /articles/:id/edits' do
        context 'with non signed in user' do
            before { get "/articles/#{@article.id}/edit" }
            
            it "rediects to the sign in page" do
                expect(response.status).to eq 302
                flash_message = "You need to sign in or sign up before continuing."
                expect(flash[:alert]).to eq flash_message
            
            end
            
            
        end
        
        context 'with signed in user who is not owner' do
            before do
                login_as(@fred)
                get "/articles/#{@article.id}/edit" 
            end
            it "redirects to the home page" do 
                expect(response.status).to eq 302
                flash_message = "You can only edit your own article." 
                expect(flash[:alert]).to eq flash_message
            end 
        
        end
        
        context 'with signed in user who owner' do
            before do
                login_as(@johndoe)
                get "/articles/#{@article.id}/edit" 
            end
            it "successfully edits the home page" do 
                expect(response.status).to eq 200
                
            end 
        
        end
        
        
    end
    
     describe 'DELETE /articles/:id' do
        context 'with non signed in user' do
            before { delete "/articles/#{@article.id}" }
            
            it "rediects to the sign in page" do
                expect(response.status).to eq 302
                flash_message = "You need to sign in or sign up before continuing."
                expect(flash[:alert]).to eq flash_message
            
            end
            
            
        end
        
        context 'with signed in user who is not owner' do
            before do
                login_as(@fred)
                delete "/articles/#{@article.id}" 
            end
            it "redirects to the home page" do 
                expect(response.status).to eq 302
                flash_message = "You can only delete your own article." 
                expect(flash[:alert]).to eq flash_message
            end 
        
        end
        
        context 'with signed in user who owner' do
            before do
                login_as(@johndoe)
                get "/articles/#{@article.id}/edit" 
            end
            it "successfully edits the home page" do 
                expect(response.status).to eq 200
                
            end 
        
        end
        
        
    end

    describe 'GET /articles/:id' do 
        context 'with existing article' do
            before { get "/articles/#{@article.id}" }
            it "handles existing article" do 
                expect(response.status).to eq 200
            end 
        end
        context 'with non-existing article' do 
            before { get "/articles/xxxxx" }
            it "handles non-existing article" do 
                expect(response.status).to eq 302
                flash_message = "The article you are looking for could not be found"
                expect(flash[:alert]).to eq flash_message
            end 
        end
    end 
end