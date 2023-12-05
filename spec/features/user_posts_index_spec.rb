require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  before do
    @user = User.create!(name: 'Lilly', posts_counter: 0)
    @posts = []
    10.times do |i| # Updated to create more posts for pagination test
      @posts << Post.create!(title: "Post #{i}", body: "Body of post #{i}", author: @user)
    end
    @posts.each do |post|
      Comment.create!(text: 'Great post!', user: @user, post:) # Fix for creating comments
      Like.create!(user: @user, post:) # Fix for creating likes
    end
  end

  scenario 'I can see the user\'s profile picture, username, and number of posts' do
    visit user_posts_path(@user)
    expect(page).to have_css('.profile-image')
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Number of posts: #{@user.posts.size}")
  end

  scenario 'I can see a post\'s title, body, comments, comment count, and like count' do
    visit user_posts_path(@user)
    @posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_css('.profile-image')
      truncated_body = post.body.length > 100 ? "#{post.body[0...100]}..." : post.body
      expect(page).to have_content(truncated_body)
      expect(page).to have_content("Comments: #{post.comments.size}, Likes: #{post.likes.size}")
      post.comments.last(5).each do |comment|
        expect(page).to have_content(comment.user.name)
        expect(page).to have_content(comment.text)
      end
    end
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user)
    # Adjust the expectation based on your actual pagination implementation
    expect(page).to have_link('Create New Post')
    expect(page).to have_link('Go Back')
  end

  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    visit user_posts_path(@user)

    # Click on the link for the first post
    find_link('Post 0').click

    # Verify that it redirects to the first post's show page
    expect(page).to have_current_path(user_post_path(@user, @posts.first))
  end
end
