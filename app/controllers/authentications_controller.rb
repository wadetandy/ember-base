class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!

  def linkedin
    @user = user_for_provider(:linkedin)
    if @user.persisted?
      sign_in @user, event: :authentication
      render 'callback'
    else
      render status: 500, json: @user.errors
    end
  end

  def failure
    flash[:alert] = "You must authenticate with LinkedIn to proceed."
    redirect_to root_path
  end

  private
  def user_for_provider(provider)
    if current_user
      current_user.add_third_party_authentication(:linkedin, request.env['omniauth.auth'])
      current_user
    else
      User.find_or_create_by_third_party_authentication(request.env['omniauth.auth'])
    end
  end
end
