class TwonksController < ApplicationController
  before_filter :check_for_ownership, :only => [:edit, :update, :destroy]
  
  def index
    @top_twonks = Twonk.find(:all, :order => "votes_count DESC", :conditions => ["accepted = ?", true], :limit => 20)
    @most_recent_twonks = Twonk.find(:all, :order => "id DESC", :conditions => ["accepted = ?", true],  :limit => 20)
  end

  def new
    @twonk = Twonk.new
    @vote = @twonk.votes.build
  end

  def create
    @twonk = current_ip.nominations.new(params[:twonk])
    if @twonk.save
      @twonk.votes.create(params[:vote].merge(:ip => current_ip))
      flash[:success] = "Twonk has been nominated and placed into the moderation queue!"
      redirect_to twonks_path
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
    @twonk = Twonk.find(params[:id], :conditions => ["accepted = ?", true], :include => [:for_votes, :against_votes, :votes])
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
    unless @twonk.nominated_by == current_ip
      flash[:notice] = "That is not your twonk to change!"
      redirect_back_or_default(twonks_path)
    end
  rescue ActiveRecord::RecordNotFound
    not_found
  end
  
  def not_found
    flash[:failure] = "The twonk you were looking for is not accepted yet, no longer exists, or never existed."
    redirect_to twonks_path
  end
end
