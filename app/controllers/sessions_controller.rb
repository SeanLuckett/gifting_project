class SessionsController < ApplicationController
  def test_page
  end

  def create
    #raise env['omniauth.auth'].to_yaml
    redirect_to test_page_path
  end
end
