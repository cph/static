class HomeController < ApplicationController
  
  def index
    @users = User.all
    @assessment = Assessment.current
  end
  
end
