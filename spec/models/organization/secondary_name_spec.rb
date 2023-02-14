require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to secondary_name" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_name)
  end
end