class ApplicationController < ActionController::Base
  include SessionsHelper
  include CoachSessionsHelper
  include UsersHelper
  include CoachesHelper
end
