require 'rails_helper'

RSpec.describe 'Sessions' do
  it 'signs user in and out' do
    user = create(:user)

    sign_in user
    get new_user_registration_path
    expect(controller.current_user).to eq(user)

    sign_out user
    get new_user_registration_path
    expect(controller.current_user).to be_nil
  end
end
