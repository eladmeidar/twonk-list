class TwonksController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  def index
    @top_twonks = Twonk.find(:all, :order => "votes_count DESC", :limit => 20)
    @most_recent_twonks = Twonk.find(:all, :order => "id DESC", :limit => 20)
    @users = User.find(:all, :order => "nomination_count DESC", :limit => 20)
  end

  def new
    @twonk = Twonk.new
    @vote = @twonk.votes.build
  end

  def create
    @twonk = current_user.nominations.new(params[:twonk])
    @twonk.votes_count = 1
    if @twonk.save
      @twonk.votes.create(:user => current_user, :comment => params[:vote][:comment])
      flash[:success] = "Twonk has been nominated!"
      redirect_to @twonk
    else
      flash[:failure] = "Twonk could not be nominated!"
      render :action => "new"
    end
  end
  
  def show
    @twonk = Twonk.find(params[:id], :include => [:for_votes, :against_votes, :votes])
  end
end
