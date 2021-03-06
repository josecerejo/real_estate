class ItemsController < ApplicationController

  before_filter :find_item, only:[:show, :edit, :update, :upvote, :destroy]

  def index
    @items = Item.all
  end

  def expensive
    @items = Item.where('price > 10000')
    render 'index'
  end

  def show
    unless @item
      render text: 'Page not found', status: 404
    end
  end

  def create
    @item = Item.create(params[:item])
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render 'new'
    end
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def update
    @item.update_attributes(params[:item])
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to action: 'index'
  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to action: 'index'
  end

  private

  def address_changed?
    attrs = %w(address latitude longitude)
    attrs.any?{|a| send "#{a}_changed?"}
  end

  def find_item
    @item = Item.where("id = ?", params[:id]).first
    render_404 unless @item
  end

end
