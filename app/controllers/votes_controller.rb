class VotesController < ApplicationController
  before_filter :find_twonk
  before_filter :check_for_vote, :only => [:new, :create]
  def new
     @vote = @twonk.votes.build(:ip => Ip.find_or_create_by_ip(request.remote_addr))
     @vote.positive = params[:positive] == "true"
  end 

  def create
    @vote = @twonk.votes.build(params[:vote].merge!(:ip => current_ip))
    if @vote.save
      if @vote.positive?
      flash[:success] = "You think #{@twonk.name} is really a twonk."
      else
      flash[:success] = "You don't think #{@twonk.name} is really a twonk."
      end
      redirect_to twonk_path(@twonk)
    else
      flash[:failure] = "Your vote failed. Try voting again!"
      render :action => "new"
    end
  end
 
  def edit
    @vote = Vote.find(params[:id])
    check_for_ownership
  end
  
  def update
    @vote = Vote.find(params[:id])
    check_for_ownership
    @vote.positive = params[:vote][:positive] == "true"
    params[:vote].delete(:positive)
    if @vote.update_attributes(params[:vote])
      flash[:success] = "Your vote has been changed!"
      redirect_to twonk_path(@twonk)
    else
      flash[:failure] = "Your vote could not be changed."
      render :action => "edit"
    end
  end

  private

    def check_for_ownership
       unless @vote.ip == current_ip
         flash[:failure] = "That vote does not belong to you, you twonk!"
	 redirect_to twonk_path(@twonk)
       end 
    end 
         
    def check_for_vote
      if @twonk.voters.include?(current_ip)
        flash[:notice] = "You have already voted for #{@twonk.name}, you twonk!"
	redirect_to twonk_path(@twonk)
      end
    end 

    def find_twonk
      @twonk = Twonk.find(params[:twonk_id]) unless params[:twonk_id].nil?
    end
end
