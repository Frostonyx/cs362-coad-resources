require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to phone" do
    organization = Organization.new
    expect(organization).to respond_to(:phone)
  end
end