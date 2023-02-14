require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
  it "responds to tickets" do
    resource_category = ResourceCategory.new
    expect(resource_category).to respond_to(:tickets)
  end
end
