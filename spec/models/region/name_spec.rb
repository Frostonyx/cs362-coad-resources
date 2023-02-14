require 'rails_helper'

RSpec.describe Region, type: :model do
  it "responds to name" do
    region = Region.new
    expect(region).to respond_to(:name)
  end
end
