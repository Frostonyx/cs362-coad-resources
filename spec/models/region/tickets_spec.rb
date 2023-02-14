require 'rails_helper'

RSpec.describe Region, type: :model do
  it "responds to tickets" do
    region = Region.new
    expect(region).to respond_to(:tickets)
  end
end
