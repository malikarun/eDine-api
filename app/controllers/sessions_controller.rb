class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(auth_hash)
    # self.current_user = @user
    render json: @user
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end