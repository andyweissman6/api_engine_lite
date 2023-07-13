class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    # item = Item.new(item_params)
    # if item.save
    render json: ItemSerializer.new(Item.create(item_params)), status: :created
    # else 
    #   render json: { error: }
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def verify_merchant
    #if item_params(merchant.id) != nil
      # return error
  end
end