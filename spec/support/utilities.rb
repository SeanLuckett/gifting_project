include ApplicationHelper

def sign_in_facebook_user
  set_omniauth
  visit root_path
  click_link("Sign in with Facebook")
end
