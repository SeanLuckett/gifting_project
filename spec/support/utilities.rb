include ApplicationHelper

def sign_in_user
  set_omniauth
  visit root_path
  click_link("Sign in with Facebook")
end

