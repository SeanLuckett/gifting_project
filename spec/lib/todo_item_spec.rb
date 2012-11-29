require 'spec_helper'

describe TodoItem do
  context "when recipient is missing data" do
    before { TodoItem.new("Recipient is missing data.", recipient) }
  end
end
