require 'spec_helper'

describe RecipientsController do

  describe "GET 'import_friends'" do
    it "returns http success" do
      get 'import_friends'
      response.should be_success
    end
  end

  describe "importing facebook friends" do
    context "when first time user" do
      context "when clicking submit after choosing some friends" do
        it "sets a friends imported flag for user" do
          
        end
      end
    end
  end 
end
