require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "responds to description" do
    ticket= Ticket.new
    expect(ticket).to respond_to(:description)
  end
end
