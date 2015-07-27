class PasswordResetsController < ApplicationController

  def new
  end

  def create
    unless params[:email]
      flash.alert = "Oooops! Sorry!"
      redirect_to root_path
    end
    flash.notice = "Ok! send to your Email!"
    redirect_to root_path
  end
end
