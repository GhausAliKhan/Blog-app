require 'rails_helper'
RSpec.feature 'User Post Index Page', type: :feature do
  before do
    @user = User.create!(name: 'Lilly', posts_counter: 0)
    @posts = []
    3.times do |i|
      @posts << Post.create!(title: "Post #{i}", body: "Body of post #{i}", author: @user)
    end
    @posts.each do |post|
      Comment.create!(text: 'Great post!', user: @user, post:)
      Like.create!(user: @user, post:)
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
end
