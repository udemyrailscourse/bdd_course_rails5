require "rails_helper"

RSpec.feature "Listing Articles" do
  
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @article1 = Article.create(title: "The first article", body: "Lorem ipsum dolor sit amet, consectetur.", user: @john)
    @article2 = Article.create(title: "The second article", body: "Body of 2nd article", user: @john)
  end
  
  scenario "with articles created and user not signed in" do 
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
    
  end
  
  scenario "with articles created and user signed in" do 
    login_as(@john)
    visit "/"
    
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link("New Article")
    
  end
  scenario "A user has no articles" do 
    Article.delete_all
    
    visit "/"
    
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)
    
    within ("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end
    
  end
  
  
end