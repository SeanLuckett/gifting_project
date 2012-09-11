require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { User.first }
    before do
      sign_in_user
      give_address_to(user)
      visit user_path(user)
    end

    it { should have_selector('title', text: user.name) }
    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('h3',    text: user.email) }
    it { should have_selector(:xpath, '//img[@src="http://www.placekitten.com/100/100"]') }
    it { should have_link('change',    href: "/users/#{user.id}/edit") }

    it { should have_content(user.address1) }
    it { should have_content(user.address2) }
    it { should have_content(user.city) }
    it { should have_content(user.state) }
    it { should have_content(user.zipcode) }

    context "When credit card not on file" do
      it { should have_content("No credit card entered") }
    end
  end
end
