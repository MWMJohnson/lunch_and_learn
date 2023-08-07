require 'rails_helper'

RSpec.describe Recipe do
  it "exists" do
    data = {recipe: {
      label: "Spicy Thai Pot",
      uri: "www.spicythaipot.com",
      image: "spicy thai pot image"
    }
  }

    recipe = Recipe.new(data, "thailand")
    expect(recipe.id).to eq("null")
    expect(recipe.title).to eq(data[:recipe][:label])
    expect(recipe.url).to eq(data[:recipe][:uri])
    expect(recipe.country).to eq('thailand')
    expect(recipe.image).to eq(data[:recipe][:image])
  end
end