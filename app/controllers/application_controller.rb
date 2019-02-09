class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper
  include CoachesHelper
end
