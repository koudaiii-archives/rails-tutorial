class PasswordResetsController < ApplicationController
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_filter :set_params, only: :create
  before_filter :format_to?, only: :create
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    user.send_password_reset if user
    redirect_to root_path, notice: "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if  @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif  @user.update_attributes(user_params)
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def set_params
      return redirect_to new_password_reset_path, notice: "Please set your Email" if params[:email].blank?
    end

    def format_to?
      return redirect_to new_password_reset_path, notice: "Sorry!not email format" unless params[:email] =~ VALID_EMAIL_REGEX
    end
end
