require 'rails_helper'

RSpec.describe Favorite do
  describe "validations" do
    it { should validate_presence_of :recipe_link }
    it { should validate_presence_of :recipe_title }
    it { should validate_presence_of :country }
  end

  describe "associations" do
    it { should belong_to :user }
  end
end
