require 'rails_helper'

describe Product do
  it { should have_many(:reviews) }
  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_most(30) }
  it { should validate_presence_of :price }
  it { should validate_length_of(:price).is_at_most(8) }
  it { should validate_presence_of :country }
  it { should validate_length_of(:country).is_at_most(30) }
end

describe Product do
  it("titleizes the name of an product") do
    product = Product.create({name: "peaches", price: "3.78", country: "georgia"})
    expect(product.name()).to(eq("Peaches"))
    expect(product.country()).to(eq("Georgia"))
  end
end
