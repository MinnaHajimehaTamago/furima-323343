class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :search_item, only: [:category_search_index, :category_search_result, :tag_search_index, :tag_search_result]

  def index
    @items = Item.includes(:user).order('created_at DESC')
    @tags = ItemTagReleation.all
  end

  def new
    @item = ItemTag.new
  end

  def create
    @item = ItemTag.new(item_tag_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
    if Order.exists?(item_id: @item.id)
      redirect_to root_path
    elsif current_user.id != @item.user_id
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user_id
    redirect_to root_path
  end

  def search
    @items = Item.search(params[:keyword])
  end

  def tag_suggestion
    return nil if params[:keyword] == ''

    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  def category_search_index
    set_item_column
  end

  def category_search_result
    @results = @p.result
  end

  def tag_search_index
    @tags = Tag.all.sort do |a, b|
      a[:tag_name] <=> b[:tag_name]
    end
    @items = @p.result.includes(:user, :tags)
  end

  def tag_search_result
    @results = @p.result.includes(:user, :tags)
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :state_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id,
                                 :price, images: []).merge(user_id: current_user.id)
  end

  def item_tag_params
    params.require(:item_tag).permit(:tag_name, :name, :text, :category_id, :state_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id,
                                     :price, images: []).merge(user_id: current_user.id)
  end

  def set_params
    @item = Item.find(params[:id])
    @tag = ItemTagReleation.find_by(item_id: params[:id]).tag
  end

  def search_item
    @p = Item.ransack(params[:q])
  end

  def set_item_column
    @item_name = Item.select('name').distinct
  end
end
