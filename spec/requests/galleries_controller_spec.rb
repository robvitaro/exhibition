require 'rails_helper'

RSpec.describe GalleriesController, type: :request do
  let (:artist) {create(:user)}

  before do
    @gallery = artist.galleries.create(name: 'Gallery A', description: 'Gallery A Description')
  end

  context 'when user is not logged in' do
    describe 'index' do
      it 'allows access' do
        get user_galleries_path(artist)
        expect(response).to have_http_status 200
      end
    end

    describe 'show' do
      it 'allows access' do
        get user_gallery_path(artist, @gallery)
        expect(response).to have_http_status 200
      end
    end

    describe 'new' do
      it 'denies access' do
        get new_user_gallery_path(artist)
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'create' do
      it 'denies access' do
        post user_galleries_path(artist), params: {gallery: {name: 'Name', description: 'Description'}}
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'edit' do
      it 'denies access' do
        get edit_user_gallery_path(artist, @gallery)
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'update' do
      it 'denies access' do
        put user_gallery_path(artist, @gallery), params: {gallery: {name: 'Name', description: 'Description'}}
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe 'destroy' do
      it 'denies access' do
        delete user_gallery_path(artist, @gallery)
        expect(response).to have_http_status 302
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  context 'when user is logged in' do

    before do
      sign_in artist
    end

    describe 'index' do
      it 'allows access' do
        get user_galleries_path(artist)
        expect(response).to have_http_status 200
      end
    end

    describe 'show' do
      it 'allows access' do
        get user_gallery_path(artist, @gallery)
        expect(response).to have_http_status 200
      end
    end

    describe 'new' do
      it 'allows access' do
        get new_user_gallery_path(artist)
        expect(response).to have_http_status 200
        expect(response).to render_template :new
      end
    end

    describe 'create' do
      it 'allows access' do
        post user_galleries_path(artist), params: {gallery: {name: 'Name', description: 'Description'}}
        expect(response).to have_http_status 302
        expect(response).to redirect_to user_gallery_path(artist, Gallery.last)
      end
    end

    describe 'edit' do
      it 'allows access' do
        get edit_user_gallery_path(artist, @gallery)
        expect(response).to have_http_status 200
        expect(response).to render_template :edit
      end
    end

    describe 'update' do
      it 'allows access' do
        put user_gallery_path(artist, @gallery), params: {gallery: {name: 'Name', description: 'Description'}}
        expect(response).to have_http_status 302
        expect(response).to redirect_to user_gallery_path(artist, @gallery)
      end
    end

    describe 'destroy' do
      it 'allows access' do
        expect do
          delete user_gallery_path(artist, @gallery)
        end.to change {Gallery.count}.by(-1)
        expect(response).to have_http_status 302
        expect(response).to redirect_to user_galleries_path(artist)
      end
    end
  end

  context 'when user is logged in but is not the owner' do
    let (:another_artist) {create(:user)}

    before do
      sign_in another_artist
    end

    describe 'index' do
      it 'allows access' do
        get user_galleries_path(artist)
        expect(response).to have_http_status 200
      end
    end

    describe 'show' do
      it 'allows access' do
        get user_gallery_path(artist, @gallery)
        expect(response).to have_http_status 200
      end
    end

    describe 'new' do
      it 'denies access' do
        get new_user_gallery_path(artist)
        expect(response).to have_http_status 401
      end
    end

    describe 'create' do
      it 'denies access' do
        post user_galleries_path(artist), params: {gallery: {name: 'Name', description: 'Description'}}
        expect(response).to have_http_status 401
      end
    end

    describe 'edit' do
      it 'denies access' do
        get edit_user_gallery_path(artist, @gallery)
        expect(response).to have_http_status 401
      end
    end

    describe 'update' do
      it 'denies access' do
        put user_gallery_path(artist, @gallery), params: {gallery: {name: 'Name', description: 'Description'}}
        expect(response).to have_http_status 401
      end
    end

    describe 'destroy' do
      it 'denies access' do
        delete user_gallery_path(artist, @gallery)
        expect(response).to have_http_status 401
      end
    end
  end
end
