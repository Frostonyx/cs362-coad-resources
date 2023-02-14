require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
  it "responds to active" do
    resource_category = ResourceCategory.new
    expect(resource_category).to respond_to(:active)
  end
end
