require "rails_helper"

describe "Item's Merchant" do
  before :each do
    @merchant1 = Merchant.create!(name: "Paula Pounders")
    @item1 = Item.create!( name: "Shampoo",
                          description: "Shampoo is better!",
                          unit_price: 4.20,
                          merchant_id: @merchant1.id  )
  end

  it "requests the item's merchant" do
    get "/api/v1/items/#{@item1.id}/merchant"
    
    expect(response).to be_successful
    
    items_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(items_merchant[:data][:id].to_i).to eq(@merchant1.id)    
  end
end
