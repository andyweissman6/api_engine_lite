require "rails_helper"

describe "Merchants API" do
  it "sends a list of merchants" do
    merchant_1 = Merchant.create!(name: "Paula Pounders")
    merchant_2 = Merchant.create!(name: "Big Timer Supply")
    merchant_3 = Merchant.create!(name: "Bobbicito's")

    get '/api/v1/merchants'
    expect(response).to be_successful
    
    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:type)
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to have_key(:name)
    end
  end

  it "sends one single merchant" do
    merchant_1 = Merchant.create!(name: "Paula Pounders")

    get "/api/v1/merchants/#{merchant_1.id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
    
    expect(merchant[:data][:id].to_i).to eq(merchant_1.id)    
  end
end