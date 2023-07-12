require "rails_helper"

describe "Items API" do
  it "sends a list of all items" do
    merchant_1 = Merchant.create!(name: "Paula Pounders")
    item1 = Item.create!( name: "Shampoo",
                          description: "Shampoo is better!",
                          unit_price: 4.20,
                          merchant_id: merchant_1.id  )
  
    get "/api/v1/items"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    
    items[:data].each do |item|
      expect(items).to have_key(:data)
      expect(item).to be_a(Hash)
      expect(item).to have_key(:id)
      expect(item).to have_key(:type)
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq(item1.name)
      expect(item[:attributes][:description]).to eq(item1.description)
      expect(item[:attributes][:unit_price]).to eq(item1.unit_price)
      expect(item[:attributes][:merchant_id]).to eq(item1.merchant_id)
    end
  end
end

    