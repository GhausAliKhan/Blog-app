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

  # New test cases added as per reviewer's requirements and view structures

  scenario 'I can see the user\'s profile picture' do
    visit user_path(@user)
    expect(page).to have_css('.profile-image')
  end

  scenario 'I can see the user\'s username' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 3')
  end

  scenario 'I can see the user\'s bio' do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  scenario 'I can see the user\'s first 3 posts' do
    visit user_path(@user)
    @user.posts.limit(3).each do |post|
      expect(page).to have_content("Post #{post.id}")
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.body, normalize_ws: true)
    end
  end

  scenario "I can see the post's title and body" do
    visit user_post_path(@user, @post1)
    expect(page).to have_content("Post ##{@post1.id} : #{@post1.title} by #{@user.name}")
    expect(page).to have_content(@post1.body, normalize_ws: true)
  end

  scenario 'I can see the post\'s stats (Comments and Likes)' do
    visit user_post_path(@user, @post1)
    expect(page).to have_content('Comments: 0, Likes: 0') # Adjust if the actual counts differ
  end

  scenario 'I can see comments for the post' do
    comment = @post1.comments.create(user: @user, text: 'This is a comment.')
    visit user_post_path(@user, @post1)
    expect(page).to have_selector('.comment', text: "#{comment.user.name}:")
    expect(page).to have_content("#{comment.user.name}: #{comment.text}", normalize_ws: true)
  end

  scenario 'I can see the "Add Comment" link' do
    visit user_post_path(@user, @post1)
    expect(page).to have_link('Add Comment', href: new_user_post_comment_path(@user, @post1))
  end
end
