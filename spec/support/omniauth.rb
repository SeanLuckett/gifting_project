def set_omniauth(opts = {})
  default = {:provider => :facebook,
             :uuid     => "123545",
             :facebook => {
               :email => "user@example.com",
               :gender => "Male",
               :name => "User Mcfoo",
               :image => "http://www.placekitten.com/100/100"
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
      :name => user_hash[:name],
      :image => user_hash[:image]
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
