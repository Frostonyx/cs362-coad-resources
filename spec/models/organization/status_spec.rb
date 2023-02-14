require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to status" do
    organization = Organization.new
    expect(organization).to respond_to(:status)
  end
end