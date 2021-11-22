require 'rails_helper'

RSpec.describe "Spec for admin-trader interaction", type: :system do       
    before do
        driven_by(:rack_test)
        Rails.application.routes.default_url_options[:host]= 'localhost:3000' 
        regular = Regular.create(name: 'Siren', surname: 'Trader', email: 'sirentrader@mail.com', password: '123456', password_confirmation: '123456', balance: 1234, approved: true, confirmed_at: Time.now)
        visit new_regular_session_path
        fill_in 'Email', :with => "sirentrader@mail.com"
        fill_in 'Password', :with => '123456'
        click_button 'Log in'
    end

    it "should be able to view their portfolio" do 
        visit trader_index_path
        expect(page).to have_content "My Portfolio"
    end

    it "should be able to view their transactions" do 
        visit history_index_path
        expect(page).to have_content "My Transactions"
    end

end