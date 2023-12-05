require 'rails_helper'
RSpec.feature 'Post Show Page', type: :feature do
  before do
    @user = User.create(name: 'User 1', photo: 'url1', bio: 'Bio 1')
    @post = @user.posts.create(title: 'Post Title', body: 'Post Body')
    @comment1 = @post.comments.create(user: @user, text: 'Comment 1')
    @comment2 = @post.comments.create(user: @user, text: 'Comment 2')
    3.times do
      @post.likes.create(user: @user)
    end
  end
  scenario 'I can see post details(title, author, numbers of comment&likes, body, commenter usernames)' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@post.body)
    expect(page).to have_content('Comments: 2, Likes: 3')
    @post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
      expect(page).to have_content(comment.text)
    end
  end
end
