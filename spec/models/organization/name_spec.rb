require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to name" do
    organization = Organization.new
    expect(organization).to respond_to(:name)
  end
end
