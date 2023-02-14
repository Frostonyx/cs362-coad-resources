require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "responds to name" do
    ticket= Ticket.new
    expect(ticket).to respond_to(:name)
  end
end
