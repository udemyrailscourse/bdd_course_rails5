require 'rails_helper'

RSpec.describe "Articles", type: :request do
  
  before do
    @article = Article.create(title: "Title One", body: "Body of article one")
  end
  
  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article.id}" }
      
      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end
    
    context 'with non-existing article' do
      before { get "/articles/xxxx" }
      
      it "handles non-existing article" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end