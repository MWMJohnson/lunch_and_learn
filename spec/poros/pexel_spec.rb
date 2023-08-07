require 'rails_helper'

RSpec.describe Pexel do
  it "exists" do
    attrs = {
      alt: "Picture of France",
      url: "france_image_path"
    }

    photo = Pexel.new(attrs)

    expect(photo.alt_tag).to eq(attrs[:alt])
    expect(photo.url).to eq(attrs[:url])
  end
end