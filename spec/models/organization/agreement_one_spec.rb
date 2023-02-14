require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to agreement_one" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_one)
  end
end