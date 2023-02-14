require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to email" do
    organization = Organization.new
    expect(organization).to respond_to(:email)
  end
end
