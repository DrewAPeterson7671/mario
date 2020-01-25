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

describe "the user sign out from registration" do
  it "sign out a new user" do
    visit products_path
    click_link 'Sign up'
    find('#registration_email').set('pete@pete.com')
    find('#registration_password').set('pass')
    find('#reg_password_confirm').set('pass')
    click_on 'Sign Up'
    click_on 'Sign out'
    expect(page).to have_content "You've signed out."
  end
end

describe "the user sign in" do
  it "sign in an existing user" do
    visit products_path
    click_link 'Sign up'
    find('#registration_email').set('pete@pete.com')
    find('#registration_password').set('pass')
    find('#reg_password_confirm').set('pass')
    click_on 'Sign Up'
    click_on 'Sign out'
    click_link 'Sign in'
    fill_in 'Email', :with => 'pete@pete.com'
    fill_in 'Password', :with => 'pass'
    click_button 'Sign in'
    expect(page).to have_content "You've signed in."
  end
end

describe "the user sign in" do
  it "sign in an existing user" do
    visit products_path
    click_link 'Sign up'
    find('#registration_email').set('pete@pete.com')
    find('#registration_password').set('pass')
    find('#reg_password_confirm').set('pass')
    click_on 'Sign Up'
    click_on 'Sign out'
    click_link 'Sign in'
    fill_in 'Email', :with => 'pete@pete.com'
    fill_in 'Password', :with => 'pass'
    click_button 'Sign in'
    expect(page).to have_content "You've signed in."
  end
end

describe "the user registration process for admin" do
  it "checks admin privleges" do
    visit products_path
    click_link 'Sign up'
    find('#registration_email').set('lara@lara.com')
    find('#registration_password').set('pass')
    find('#reg_password_confirm').set('pass')
    # page.check('admin_check')
    # check '#admin_check'
    # check 'Admin?'
    # find("#admin_check[value='1']").set(true)
    # check 'admin_check'
    find('#admin_check').set(true)
    click_on 'Sign Up'
    # expect(page).to have_content "Admin Only"
    expect(page).to have_content "Create new product"
  end
end

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
