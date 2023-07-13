require "rails_helper"

describe "GET /api/v1/items" do
  it "sends a list of all items" do
    @merchant1 = Merchant.create!(name: "Paula Pounders")
    @item1 = Item.create!( name: "Shampoo",
                          description: "Shampoo is better!",
                          unit_price: 4.20,
                          merchant_id: @merchant1.id  )
  
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
      expect(item[:attributes][:name]).to eq(@item1.name)
      expect(item[:attributes][:description]).to eq(@item1.description)
      expect(item[:attributes][:unit_price]).to eq(@item1.unit_price)
      expect(item[:attributes][:merchant_id]).to eq(@item1.merchant_id)
    end
  end
end

describe "GET /api/v1/items/{item_id}" do
  it "sends one single item" do
    @merchant1 = Merchant.create!(name: "Paula Pounders")
    @item1 = Item.create!( name: "Shampoo",
                          description: "Shampoo is better!",
                          unit_price: 4.20,
                          merchant_id: @merchant1.id  )

    get "/api/v1/items/#{@item1.id}"
    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:id].to_i).to eq(@item1.id)    
  end
end

describe "POST /api/v1/items" do
  it "CREATES an item" do 
    @merchant1 = Merchant.create!(name: "Paula Pounders")

    item_params = {
      name: "Used Shirt",
      description: "Couple holes and stains, but smells not the worst",
      unit_price: 6.99,
      merchant_id: @merchant1.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    
    created_item = Item.last

    expect(response).to be_successful
    expect(item_params[:name]).to eq(created_item[:name])
    expect(item_params[:description]).to eq(created_item[:description])
    expect(item_params[:unit_price]).to eq(created_item[:unit_price])
    expect(item_params[:merchant_id]).to eq(created_item[:merchant_id])
  end
end

describe "PATCH /api/v1/items (UPDATE Item)" do
  before :each do
    @merchant1 = Merchant.create!(name: "Paula Pounders")
    @item1 = Item.create!( name: "Shampoo",
                          description: "Shampoo is better!",
                          unit_price: 4.20,
                          merchant_id: @merchant1.id  )
  end

  it "updates an item" do 
    previous_name = @item1.name
    item_params = { item: { name: "Shampoopsicle" } }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{@item1.id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find_by(id: @item1.id)
    
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Shampoopsicle")
  end
end

describe "DELETE /api/v1/items (DELETE Item)" do
  before :each do
    @merchant1 = Merchant.create!(name: "Paula Pounders")
    @item1 = Item.create!( name: "Shampoo",
                          description: "Shampoo is better!",
                          unit_price: 4.20,
                          merchant_id: @merchant1.id  )
  end

  it "deletes an item" do 
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{@item1.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(@item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end