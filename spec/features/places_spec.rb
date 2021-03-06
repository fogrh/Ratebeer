require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one is returned by the API, it shows them at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ),
	Place.new( name:"Kumpulan olut", id: 2 ), Place.new( name:"Testi", id: 3 ) ]
    )
 

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kumpulan olut"
    expect(page).to have_content "Testi"
	

  end

	it "if none is returned by the API, it shows not found message" do
	   allow(BeermappingApi).to receive(:places_in).with("tyhjyys").and_return(
      []
    )
	visit places_path
	click_button "Search"
	 expect(page).to have_content "No locations in "
	
	end
end
