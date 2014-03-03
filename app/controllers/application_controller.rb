class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    return nil if session[:token].nil?
    current_session = Session.find_by_token(session[:token])

    current_session ? User.find(current_session.user_id) : nil
  end

  def logged_in?
    !!current_user
  end

  def sign_in(user)
    token = SecureRandom.urlsafe_base64
    session[:token] = token
    Session.create!(token: token, user_id: user.id)
  end
end
