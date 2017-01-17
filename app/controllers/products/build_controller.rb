class Products::BuildController < ApplicationController
  before_action :set_product

  include Wicked::Wizard
  steps :name, :price, :category

  def show
    render_wizard
  end

  def update
    @product.update_attributes(product_params)
    render_wizard @product
  end

  private
  def redirect_to_finish_wizard(options = nil)
    begin
      @product.save!
      redirect_to products_url, notice: "Thank you for regist product."
    rescue => e
      flash[:error] = "#{e.message}"
      render_wizard @product
    end
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def product_params
    params.require(:product).
    permit(:name, :price, :category).
    merge({ status: step == steps.last ? 'active' : step.to_s })
  end
end
