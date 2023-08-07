require 'rails_helper'

RSpec.describe Country do
  it "exists" do
    attrs = {
      name: {
        common: "Denmark"
      }
    }

    country = Country.new(attrs)

    expect(country.name).to be_a String
    expect(country.name).to eq("Denmark")
  end
end