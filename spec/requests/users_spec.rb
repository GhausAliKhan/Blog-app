require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  let!(:user) { User.create(name: 'Test User', bio: 'User bio', photo: 'link_to_photo.jpg') }

  describe 'GET /index' do
    before { get users_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'includes the name of the user in the response body' do
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET /show' do
    before { get user_path(user) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'includes the name of the user in the response body' do
      expect(response.body).to include(user.name)
    end
  end
end
