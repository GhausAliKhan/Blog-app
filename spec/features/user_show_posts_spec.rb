require 'rails_helper'

RSpec.feature 'User Posts Page', type: :feature do
  before do
    @user = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1', posts_counter: 3)
    @post1 = @user.posts.create(title: 'Post 1', body: 'Text 1')
    @user.posts.create(title: 'Post 2', body: 'Text 2')
    @user.posts.create(title: 'Post 3', body: 'Text 3')
  end

  scenario 'User can see most recent posts of the user' do
    visit user_path(@user)
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
    expect(page).to_not have_content('Post 4')
  end

  scenario "When I click on a post's title, it redirects me to that post's show page" do
    visit user_posts_path(@user)

    # Click on the link for the first post
    find_link('Post 1').click

    # Verify that it redirects to the first post's show page
    expect(page).to have_current_path(user_post_path(@user, @post1))
  end
  scenario "I can see a button that lets me view all of a user's posts" do
    visit user_path(@user)
    expect(page).to have_link('See all posts', href: user_posts_path(@user))
  end
end
