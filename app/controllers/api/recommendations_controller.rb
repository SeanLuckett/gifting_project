class RecommendationsController < ApplicationController
  skip_before_filter :require_login

  def generate
  end
end