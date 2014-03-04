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

  def set_flash(type, message)
    flash[type.to_sym] ||= []
    message.is_a?(String) ? flash[type.to_sym] << message : flash[type.to_sym] += message
  end

  def set_flash_now(type, message)
    flash.now[type.to_sym] ||= []
    if message.is_a?(String)
      flash.now[type.to_sym] << message
    else
      flash.now[type.to_sym] += message
    end
  end
end
