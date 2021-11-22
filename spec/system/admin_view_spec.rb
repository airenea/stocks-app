require 'rails_helper'

RSpec.describe "Spec for Admin View", type: :system do   
    before do
        driven_by(:rack_test)
        Rails.application.routes.default_url_options[:host]= 'localhost:3000' 
        Admin.create(name: 'admin', surname: 'test', email: 'admintest@gmail.com', password: '123456', password_confirmation: '123456', approved: true, confirmed_at: Time.now)
        Regular.create(name: 'Regular', surname: 'Trader', email: 'regulartrader@gmail.com', password: '123456', password_confirmation: '123456', approved: true, confirmed_at: Time.now)
        # create, and log in adimn
        visit new_admin_session_path
        fill_in 'Email', :with => 'admintest@gmail.com'
        fill_in 'Password', :with => '123456'
        click_button 'Log in'
    end
    
    describe 'Admin Dashboard'
    it "1. Should allow the admin to access their Dashboard" do
        visit pending_users_path
            expect(page).to have_content "All Users"
            expect(page).to have_content "Pending Users"
            expect(page).to have_content "All Transactions"
    end

    describe 'Admin View All Users'
    it "2. Should allow admin to view all users" do
        visit '/all_users'
            expect(page).to have_content "All Users"
    end

    describe 'Admin View All Transactions'
    it "3. Should allow admin to view all transactions" do
        visit all_transactions_path
        click_link 'All Transactions'
            expect(page).to have_content "Date"
            expect(page).to have_content "Stock"
            expect(page).to have_content "Buyer"
            expect(page).to have_content "Seller"
            expect(page).to have_content "Price"
    end

    describe 'Admin View a User'
    it "4. Should allow admin to view a user" do
        visit all_users_path
        expect(page).to have_content "All Users"
        click_link "Regular Trader"
            expect(page).to have_content "Regular Trader"
        end
    end
    


    

    

