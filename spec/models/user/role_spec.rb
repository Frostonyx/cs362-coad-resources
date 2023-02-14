require 'rails_helper'

RSpec.describe User, type: :model do
  it "responds to role" do
    user= User.new
    expect(user).to respond_to(:role)
  end
end
