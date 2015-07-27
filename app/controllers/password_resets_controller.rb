class PasswordResetsController < ApplicationController
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_filter :set_params, only: :create
  before_filter :format_to?, only: :create
  def new
  end

  def create
    flash.notice = "Ok! send to your Email!"
    redirect_to root_path
  end

  private
    def set_params
      return redirect_to new_password_reset_path, notice: "Please set your Email" if params[:email].blank?
    end

    def format_to?
      return redirect_to new_password_reset_path, notice: "Sorry!not email format" unless params[:email] =~ VALID_EMAIL_REGEX 
    end
end
