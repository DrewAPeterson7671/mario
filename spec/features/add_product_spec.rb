require 'rails_helper'

describe "Unregistered user can view product page" do
  it "adds a new product" do
    visit products_path
    click_link 'Return to products'
    expect(page).to have_content 'Mario'
  end
end


describe "the user registration process" do
  it "takes user to registration page" do
    visit products_path
    click_link 'Sign up'
    expect(page).to have_content "Email"
  end
end


describe "the user registration process" do
  it "registers a user" do
    visit products_path
    click_link 'Sign up'
    find('#registration_email').set('pete@pete.com')
    find('#registration_password').set('pass')
    find('#reg_password_confirm').set('pass')
    click_on 'Sign Up'
    expect(page).to have_content "You've successfully signed up!"
  end
end





#
# describe "the user registration process" do
#   it "registers a user" do
#     visit products_path
#     click_link 'Sign up'
#     fill_in 'Email', :with => 'chet@chet.com'
#     fill_in 'Password', :with => 'pass'
#     fill_in 'Password confirmation', :with => 'pass'
#     click_on 'Sign Up'
#     expect(page).to have_content "You've successfully signed up!"
#   end
# end




# describe "the add a product process" do
#   it "adds a new product" do
#     visit products_path
#     click_link 'Create new product'
#     fill_in 'Name', :with => 'Grapes'
#     fill_in 'Price', :with => '3.46'
#     fill_in 'Country', :with => 'Brazil'
#     click_on 'Create Product'
#     expect(page).to have_content 'Product successfully added!'
#     expect(page).to have_content 'Grapes'
#   end
# end


#   it "gives an error when no name is entered" do
#     visit new_product_path
#     click_on 'Create Product'
#     expect(page).to have_content "Name can't be blank"
#     expect(page).to have_content "Price can't be blank"
#     expect(page).to have_content "Country can't be blank"
  # end
