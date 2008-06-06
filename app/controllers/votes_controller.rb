class VotesController < ApplicationController
  before_filter :find_twonk
  def new
   @vote = @twonk.votes.build(:user_id => session[:user])
   @vote.positive = params[:positive] 
  end 

  def create
    @vote = @twonk.votes.build(params[:vote])
    if @vote.save
      if @vote.positive?
      flash[:success] = "You think #{@twonk.name} is really a twonk."
      @twonk.increment!(:vote_count)
      else
      flash[:success] = "You don't think #{@twonk.name} is really a twonk."
      @twonk.decrement!(:vote_count)
      end
      redirect_to twonk_path(@twonk)
    else
      flash[:failure] = "Your vote failed. Try voting again!"
      render :action => "new"
    end
  end

  private

    def find_twonk
    @twonk = Twonk.find(params[:twonk_id]) unless params[:twonk_id].nil?
    end
end
