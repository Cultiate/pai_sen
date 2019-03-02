class RootController < ApplicationController
  def top
    @coaches = Coach.all.order("created_at desc")
  end

  def contact
  end

  def faq
  end
  
end
