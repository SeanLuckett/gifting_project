require 'spec_helper'

describe RecipientsController do

  describe "GET 'import_friends'" do
    it "returns http success" do
      get 'import_friends'
      response.should be_success
    end
  end

end
