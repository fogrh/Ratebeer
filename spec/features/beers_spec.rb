require 'rails_helper'

describe "Beers page" do

 before :each do
    FactoryGirl.create(:brewery)
    FactoryGirl.create(:user)
    sign_in(username:"Pekka", password:"Foobar1")
  end

  describe "a new beer is" do
	it "added when the credentials are right" do
    	visit new_beer_path
    	fill_in('beer_name', with:'testiolut')
	 
	expect{ click_button('Create Beer') }.to change{Beer.count}.by(1) 
  	end
	it "not valid or added with wrong credentials" do
	visit new_beer_path
	click_button('Create Beer')

	expect(current_path).to eq(beers_path)
      	expect(page).to have_content "Name can't be blank"
  	end
end
end
