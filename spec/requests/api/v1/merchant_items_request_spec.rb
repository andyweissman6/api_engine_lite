require "rails_helper"

describe "Merchant Items API" do
  it "sends a list of merchants' items" do
    @merchant1 = Merchant.create!(name: "Paula Pounders")
    @item1 = Item.create!( name: "Shampoo",
                          description: "Shampoo is better!",
                          unit_price: 4.20,
                          merchant_id: @merchant1.id  )
    @item2 = Item.create!( name: "Conditioner",
                          description: "I make hair silky and smooth!",
                          unit_price: 3.99,
                          merchant_id: @merchant1.id  )
    @item3 = Item.create!( name: "Blue Duck",
                          description: "I drew the duck blue because I've never seen a blue duck before, and to be honest with you, I wanted to see a blue duck.",
                          unit_price: 100.25,
                          merchant_id: @merchant1.id  )
    
    get "/api/v1/merchants/#{@merchant1.id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body, symbolize_names: true)
    
    merchant_items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
    
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to eq(@merchant1.id)
    end
  end
end