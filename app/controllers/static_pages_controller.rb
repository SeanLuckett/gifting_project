class StaticPagesController < ApplicationController
  skip_before_filter :require_login
  layout 'app_with_menu', :except => [:home]
  
  def home
  end

  def support
  end

end
