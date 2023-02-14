require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to transportation" do
    organization = Organization.new
    expect(organization).to respond_to(:transportation)
  end
end