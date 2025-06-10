class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    filterrific = initialize_filterrific_instance or
      return render json: { error: 'Invalid filter params' }, status: :unprocessable_entity

    products = filterrific.find.page(params[:page]).per(10)

    render json: render_products_json(products, filterrific)
  end

  # GET /products/:id
  def show
    if @product.published? || current_user&.id == @product.seller_id
      render json: @product
    else
      render json: { error: "Product not found" }, status: :not_found
    end
  end

  # POST /products
  def create
    product = Product.new(product_params)
    product.seller_id = current_user.id

    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/:id
  def update
    if @product.seller_id != current_user.id
      return render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    if @product.seller_id != current_user.id
      return render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    @product.destroy
    render json: { message: 'Product deleted successfully' }
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    render json: { error: 'Product not found' }, status: :not_found unless @product
  end

  def initialize_filterrific_instance
    initialize_filterrific(
      Product,
      filter_params,
      select_options: {
        with_category: Product.distinct.pluck(:category).sort
      }
    )
  end

  def filter_params
    params.fetch(:filter, {}).permit(:search_query, :with_category, :with_price_gte, :with_price_lte, :with_tags)
  end

  def product_params
    params.require(:product).permit(
      :title,
      :description,
      :price,
      :category,
      :thumbnail,
      :allowed,
      :published,
      tag_list: [] # assuming acts_as_taggable_on
    )
  end

  def render_products_json(products, filterrific)
    {
      products: products.as_json(only: [:id, :title, :category, :price, :rating_avg]),
      pagination: {
        current_page: products.current_page,
        total_pages: products.total_pages,
        total_count: products.total_count
      }
    }
  end
end
