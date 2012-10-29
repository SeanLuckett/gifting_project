require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    before { sign_in_facebook_user }
    let(:user) { User.first }
    it "returns http success" do
    end
  end

end
