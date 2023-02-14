require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "responds to agreement_four" do
    organization = Organization.new
    expect(organization).to respond_to(:agreement_four)
  end
end