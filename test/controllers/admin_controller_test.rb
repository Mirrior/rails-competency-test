require "test_helper"

describe AdminController do
  include Devise::Test::IntegrationHelpers

  let(:user)  { users :valid  }
  let(:admin) { users :admin }

  it "shows admins users" do
    sign_in admin
    get admin_url(user)
    value(response).must_be :success?
  end

  it "gets index" do
    sign_in admin
    get admin_index_url
    value(response).must_be :success?
  end

  it "gets new" do
    sign_in admin
    get new_admin_url
    value(response).must_be :success?
  end

  # it "creates user" do
  #   sign_in admin
  #   expect {
  #     post admin_index_url, params: { user: { email: user.email, password: "000000", password_confirmation: "000000" } }
  #   }.must_change "User.count"
  #
  #   must_redirect_to admin_path(User.last)
  # end

  it "gets edit" do
    sign_in admin
    get edit_admin_url(user)
    value(response).must_be :success?
  end

  it "updates user" do
    sign_in admin
    patch admin_url(user), params: { user: { email: user.email,  roles: user.roles } }
    must_redirect_to admin_path(user)
  end
end
