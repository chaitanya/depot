class StoreController < ApplicationController
  
  def index
    unless session[:counter]==nil
      session[:counter] += 1
    else
      session[:counter]=0
    end   
    @products = Product.find_products_for_sale
    @cart = find_cart 
  end
  
  def add_to_cart
    begin
      product = Product.find(params[:id])   
      
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}" )
      flash[:notice] = "Invalid product"
      redirect_to_index("Invalid product" )
    else
      
      @cart = find_cart
      @current_item = @cart.add_product(product)
      logger.info "#{product}---#{@cart}---#{@current_item}"
       session[:counter]=0
      respond_to do |format|
        format.js
      end
    end
  end
  
  def empty_cart
    session[:cart] = nil
    flash[:notice] = "Your cart is currently empty"
    redirect_to_index("Your cart is currently empty" )
  end
  
  private 
  
  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def redirect_to_index(msg=nil)
    flash[:notice] = msg
    redirect_to :action => :index
  end
  
end
