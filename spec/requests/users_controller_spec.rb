require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let (:artist) {create(:user)}

  describe 'index' do
    it 'allows access' do
      get users_path
      expect(response).to have_http_status 200
      expect(response).to render_template :index
    end
  end

  describe 'show' do
    it 'allows access' do
      get user_path(artist)
      expect(response).to have_http_status 200
      expect(response).to render_template :show
    end
  end
end
