require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to secondary_phone" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_phone)
  end
end