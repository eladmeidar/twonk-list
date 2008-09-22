class Admin::ApplicationController < ApplicationController
  before_filter :login_required
  include AuthenticatedSystem
end