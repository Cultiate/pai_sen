class ApplicationController < ActionController::Base
  include SessionsHelper
  include StudentsHelper
  include CoachesHelper
end
