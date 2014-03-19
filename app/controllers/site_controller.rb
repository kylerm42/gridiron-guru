class SiteController < ApplicationController
  def root
    if logged_in?
      @user = User
    else

    end
    render :root
  end
end
