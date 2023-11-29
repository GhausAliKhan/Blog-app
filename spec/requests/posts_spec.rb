require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  # Create a user and a post before the tests run
  let!(:user) { User.create!(name: 'Test User', bio: 'User bio', photo: 'link_to_photo.jpg') }
  let!(:post) { Post.create!(title: 'Test Post', body: 'This is a test post', author: user) }

  describe 'GET /index' do
    before { get user_posts_path(user) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the title of the post in the response body' do
      expect(response.body).to include(post.title)
    end
  end

  describe 'GET /show' do
    before do
      get user_post_path(user, post)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes the title and text of the post in the response body' do
      expect(response.body).to include(post.title).and include(post.body)
    end
  end
end
