# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :check_for_dickheads
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation 
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '15a7a949f12f35e09964dc8e20252a2c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def check_for_dickheads
    # Defaced the site on 16th Sep 2008
    if !/^122\.109\..*/.match(request.remote_addr).nil? ||
    # Probably the same person as above.
       !/^124\.190\..*/.match(request.remote_addr).nil? 
    # Spammed the site on the 18th Sep 2008, probably same person as above
    # Site resolves to http://youhide.com
       !/^208\.99\..*/.match(request.remote_addr).nil?
      redirect_to "http://www.google.com/search?q=how+not+to+be+a+fucktard"
    end
  end
end
