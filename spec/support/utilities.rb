include ApplicationHelper

def sign_in_user
  set_omniauth
  visit root_path
  click_link("Sign in with Facebook")
end

def give_address_to(user)
  user.update_attributes(
    :address1 => "1234 Wacky Way",
    :address2 => "#206",
    :city     => "Springfield",
    :state    => "MA",
    :zipcode  => "01199"
  )
end
