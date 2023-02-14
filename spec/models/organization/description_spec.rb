require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to description" do
    organization = Organization.new
    expect(organization).to respond_to(:description)
  end
end