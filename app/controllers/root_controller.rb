class RootController < ApplicationController
  def top
    @coaches = Coach.all.order("created_at desc")
  end
end
