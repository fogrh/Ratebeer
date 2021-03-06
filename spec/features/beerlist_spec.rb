require 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create beerstyle: "Lager"
    @style2 = Style.create beerstyle: "Rauchbier"
    @style3 = Style.create beerstyle: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

   it "shows a known beer", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Nikolai"
  end
  it "shows beers names in alphabetical order as default", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
	save_and_open_page
	expect(page).to have_content "Fastenbier"
   find('table').find('tr:nth-child(3)')
	save_and_open_page
	expect(page).to have_content "Lechte Weisse"
  find('table').find('tr:nth-child(4)')
	save_and_open_page
	expect(page).to have_content "Nikolai"
  end
  it "when styles are selected, it shows them in alphabetical order", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(1)')
	save_and_open_page
	find_link('Style').click
   	find('table').find('tr:nth-child(2)')
	expect(page).to have_content "Lager"
 	find('table').find('tr:nth-child(3)')
	expect(page).to have_content "Rauchbier"
	find('table').find('tr:nth-child(4)')
	expect(page).to have_content "Weizen"
  end
it "when breweries are selected, it shows them in alphabetical order", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(1)')
	save_and_open_page
	find_link('Brewery').click
   	find('table').find('tr:nth-child(2)')
	expect(page).to have_content "Ayinger"
 	find('table').find('tr:nth-child(3)')
	expect(page).to have_content "Koff"
	find('table').find('tr:nth-child(4)')
	expect(page).to have_content "Schlenkerla"
  end
end
