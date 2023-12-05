require 'rails_helper'
RSpec.feature 'User Post Index Page Links', type: :feature do
  before do
    # Adjust this to match the actual attributes of your User model
    @user = User.create!(name: 'TestUser')
    # Create posts for the user
    3.times do |i|
      @user.posts.create!(title: "Test Post #{i}", body: "Test body #{i}")
    end
  end
  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    visit user_posts_path(@user)
    @user.posts.each_with_index do |post, index|
      find_link(post.title).click
      expect(page).to have_current_path(user_post_path(@user, post))
      visit user_posts_path(@user) if index < @user.posts.count - 1
    end
  end
end
