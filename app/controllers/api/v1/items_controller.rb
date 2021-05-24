class Api::V1::ItemsController < ApplicationController
  before_action :find_item, only: [:show, :update]

  def index
    items = Item.pagination(params.fetch(:per_page, 20).to_i, params.fetch(:page, 1).to_i)
    render json: ItemSerializer.new(items)
  end

  def show
    # item = Item.find(params[:id])
    render json: ItemSerializer.new(@item)
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item), status: :created
  end

  def update
    @item.update!(item_params)
    render json: ItemSerializer.new(@item)
  end

  def destroy
    Item.destroy(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

end
