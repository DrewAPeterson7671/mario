require 'rails_helper'

describe Review do
  it { should belong_to(:product) }
  it { should validate_presence_of :author }
  it { should validate_length_of(:author).is_at_most(30) }
  it { should validate_presence_of :content_body }
  it { should validate_length_of(:content_body).is_at_least(50) }
  it { should validate_length_of(:content_body).is_at_most(250) }
  it { should validate_presence_of :rating }
  it { should validate_numericality_of(:rating).only_integer }
  it { should validate_numericality_of(:rating). is_less_than_or_equal_to(5)  }
  it { should validate_numericality_of(:rating). is_greater_than_or_equal_to(1)  }
end

describe Review do
  it("titleizes the author of a review") do
    product = Review.create({author: "mr meseeks", content_body: "Note that this schema.rb definition is the authoritative source for your database schema. If you need to create the application database on another", rating: 5})
    expect(product.name()).to(eq("Mr Meseeks"))
  end
end
