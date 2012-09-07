def set_omniauth(opts = {})
  default = {:provider => :facebook,
             :uuid     => "1234",
             :facebook => {
                            :email => "user@example.com",
                            :gender => "Male",
                            :first_name => "user",
                            :last_name => "mcfoo"
                          }
            }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  OmniAuth.config.test_mode = true

  # This hash is no longer correct.  See https://github.com/mkdynamic/omniauth-facebook#auth-hash
  # for latest hash structure.
  # TODO use this code iff need it in tests due to multiple calls to omniauth.auth hash
  OmniAuth.config.mock_auth[provider] = {
    'uid' => credentials[:uuid],
    "extra" => {
      "user_hash" => {
        "email" => user_hash[:email],
        "first_name" => user_hash[:first_name],
        "last_name" => user_hash[:last_name],
        "gender" => user_hash[:gender]
      }
    }
  }
end

def set_invalid_omniauth(opts = {})

  credentials = { :provider => :facebook,
                  :invalid  => :invalid_credentials
                }.merge(opts)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

end
