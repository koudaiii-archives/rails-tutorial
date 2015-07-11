# Micropost
class MicropostsController < ApplicationController
  REPLY_TO_REGEX = /@(\w[a-zA-z0-9]*)\s/i
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.all
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.in_reply_to_id = extract_in_reply_to(@micropost.content)
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_path, notice: 'Micropost created!' }
        format.json { render :show, status: :created, location: @micropost }
      else
        @feed_items = []
        format.html { render 'static_pages/home', notice: 'Sorry! not create!' }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Micropost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def extract_in_reply_to(content)
      unless content.empty? || REPLY_TO_REGEX.match(content).to_s.empty?
        User.find_by(account_name: REPLY_TO_REGEX.match(content)[1].to_s ).id
      end
    end
end
