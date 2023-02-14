require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "responds to phone" do
    ticket= Ticket.new
    expect(ticket).to respond_to(:phone)
  end
end
