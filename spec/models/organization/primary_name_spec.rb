require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to primary_name" do
    organization = Organization.new
    expect(organization).to respond_to(:primary_name)
  end
end