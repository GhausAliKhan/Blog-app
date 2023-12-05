require 'rails_helper'

RSpec.feature 'User Details Page', type: :feature do
  before do
    @user = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1', posts_counter: 3)
    3.times do |i|
      @user.posts.create(title: "Post #{i + 1}", body: "Text #{i + 1}")
    end
  end

  scenario 'User can see details of a specific user (picture, username, bio, number of posts)' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.bio)
    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_css('.profile-image')
  end

  scenario "User can click on 'See all posts' button and be redirected to the post page" do
    visit user_path(@user)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
