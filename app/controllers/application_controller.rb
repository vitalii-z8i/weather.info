class ApplicationController < ActionController::Base
  protect_from_forgery

  include ActionController::Cookies

  before_filter :init_user

  # Generates user identifier for searches
  # Or creates current user from existing cookie
  def init_user
    cookies[:user] = { :value => User.generate_user_id, :expires => Time.now + 1209600} if cookies[:user].nil?

    @current_user = User.new(cookies[:user])
  end
end
