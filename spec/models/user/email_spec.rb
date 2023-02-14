require 'rails_helper'

RSpec.describe User, type: :model do
  it "responds to email" do
    user= User.new
    expect(user).to respond_to(:email)
  end
end
