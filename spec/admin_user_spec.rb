require 'rails_helper'

RSpec.describe "Spec for admin-trader interaction", type: :system do       
    before do
        driven_by(:rack_test)
        Rails.application.routes.default_url_options[:host]= 'localhost:3000' 
        admin = Admin.create(name: 'RSpec', surname: 'Admin', email: 'yivip85112@luxiu2.com', password: '123456', password_confirmation: '123456', approved: true, confirmed_at: Time.now)
        regular = Regular.create(name: 'RSpec', surname: 'Regular', email: 'rspecreg@gmail.com', password: '123456', password_confirmation: '123456', approved: true, confirmed_at: Time.now)
        visit new_admin_session_path
        fill_in 'Email', :with => "yivip85112@luxiu2.com"
        fill_in 'Password', :with => '123456'
        click_button 'Log in'
    end

    it "should allow admin to create a user" do 
        visit all_users_path
        expect(page).to have_content "All Users"
        click_link '+T'
        fill_in 'Email', :with => "rspectrader@gmail.com"
        fill_in 'Name', :with => "RSpec"
        fill_in 'Surname', :with => "Create"
        fill_in 'Balance', :with => 12345.22
        fill_in 'Password', :with => '123456'
        fill_in 'Password confirmation', :with => '123456'
        click_button 'Create User'
        expect(page).to have_content "RSpec Create"
    end

    it "should allow admin to view a user" do 
        visit all_users_path
        expect(page).to have_content "All Users"
        click_link 'RSpec Regular'
        expect(page).to have_content "RSpec Regular"
    end

    it "should allow admin to update a user" do 
        visit all_users_path
        expect(page).to have_content "All Users"
        click_link 'RSpec Regular'
        expect(page).to have_content "RSpec Regular"
        click_link 'Edit'
        fill_in 'Name', :with => "Edited"
        click_button 'Edit User'
        expect(page).to have_content "Edited Regular"
    end
end