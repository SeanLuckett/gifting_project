def set_omniauth(opts = {})
  default = {:provider => :facebook,
             :uuid     => "123545",
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

  OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
    :uid => credentials[:uuid],
    :info => {
      :email => user_hash[:email],
      :first_name => user_hash[:first_name],
      :last_name => user_hash[:last_name],
    },
    :credentials => {
      :token => "ABCDEF...",
      :expires_at => Time.now
    }
  })
end

# TODO implement this for a test or delete it
#def set_invalid_omniauth(opts = {})

  #credentials = { :provider => :facebook,
                  #:invalid  => :invalid_credentials
                #}.merge(opts)

  #OmniAuth.config.test_mode = true
  #OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

#end
