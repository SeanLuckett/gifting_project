require 'rabl'
Rabl.configure do |config|
  config.json_engine = ActiveSupport::JSON
end
