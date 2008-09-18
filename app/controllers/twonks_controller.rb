class TwonksController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :check_for_ownership, :only => [:edit, :update, :destroy]
  
  def index
    @top_twonks = Twonk.find(:all, :order => "votes_count DESC", :limit => 20)
    @most_recent_twonks = Twonk.find(:all, :order => "id DESC", :limit => 20)
  end

  def new
    @twonk = Twonk.new
    @vote = @twonk.votes.build
  end

  def create
    # To stop you-know-who (Nick) from spamming my name...
    if !/Ryan Bigg/.match(params[:twonk][:name]).nil? 
      @twonk = Twonk.find_by_name("Ryan Bigg")
      params[:vote][:comment] = ""
    end
    @twonk ||= current_user.nominations.new(params[:twonk])
    if @twonk.save
      @vote = @twonk.votes.create(params[:vote].merge(:ip => current_user))
      flash[:success] = "Twonk has been nominated!"
      redirect_to twonk_path(@twonk)
    else
      flash[:failure] = "Twonk could not be nominated!"
      render :action => "new"
    end
  end
  
  def edit
    #placeholder
  end
  
  def update
    if @twonk.update_attributes(params[:twonk])
      flash[:success] = "Twonk has been updated."
      redirect_to @twonk
    else
      flash[:failure] = "Twonk could not be updated."
      render :action => "edit"
    end
  end
  
  def show
    @twonk = Twonk.find(params[:id], :include => [:for_votes, :against_votes, :votes])
  rescue ActiveRecord::RecordNotFound
    not_found
  end
  
  def destroy
    @twonk.destroy
    flash[:success] = "#{@twonk} has been untwonked!"
    redirect_to twonks_path
  end
  
  def check_for_ownership
    @twonk = Twonk.find(params[:id])
    unless @twonk.nominated_by == current_user
      flash[:notice] = "That is not your twonk to change!"
      redirect_back_or_default(twonks_path)
    end
  rescue ActiveRecord::RecordNotFound
    not_found
  end
  
  def not_found
    flash[:failure] = "The twonk you were looking for no longer exists, or never existed."
    redirect_to twonks_path
  end
end
