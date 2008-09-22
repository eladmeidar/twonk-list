class Admin::TwonksController < Admin::ApplicationController
  def index
    @twonks = Twonk.find_all_by_accepted(false)
  end
  
  def accept
    twonk = Twonk.find(params[:id])
    twonk.accepted = true
    twonk.save
    flash[:notice] = "Twonk #{@twonk.name} accepted."
    redirect_to admin_twonks_path
  end
  
  def destroy
    Twonk.find(params[:id]).destroy
    flash[:notice] = "Selected twonk has been deleted."
    redirect_to admin_twonks_path
  end
end