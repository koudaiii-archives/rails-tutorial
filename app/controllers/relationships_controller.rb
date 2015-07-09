class RelationshipsController < ApplicationController
  before_action :signed_in_user
  after_action :notification_mail

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private
    def notification_mail
      UserMailer.welcome_email(@user).deliver_later
    end
end
