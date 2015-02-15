require 'rails_helper'

RSpec.describe Beer, type: :model do

	
   describe "with proper name and style" do
	it "is valid and saved" do
	  beer = FactoryGirl.create(:beer) 
	  expect(beer).to be_valid
          expect(Beer.count).to eq(1)
	end      	  	
   end

   describe "is not" do
	it "valid without a name" do
	style = FactoryGirl.create(:style)
	beer = Beer.create name:"", style_id: style.id
	expect(beer).not_to be_valid
	end
	it "or valid without a style" do
	beer = Beer.create name:"Testiolut"
	expect(beer).not_to be_valid
	end
   end
end
