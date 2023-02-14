require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "responds to closed" do
    ticket= Ticket.new
    expect(ticket).to respond_to(:closed)
  end
end
