class TwonksController < ApplicationController
  def index
    @twonks = Twonk.find(:all)
  end

  def new
    @twonk = Twonk.new
    @vote = @twonk.votes.build
  end

  def create
    @twonk = Twonk.new(params[:twonk].merge({ :vote_count => 1 }))
    if @twonk.save
      @twonk.votes.create(:user => current_user, :comment => params[:vote][:comment])
      flash[:success] = "Twonk has been nominated!"
      redirect_to twonk_path(@twonk)
    else
      flash[:failure] = "Twonk could not be nominated!"
      render :action => "new"
    end
  end
  
  def show
    @twonk = Twonk.find(params[:id], :include => [:votes])
  end
end
