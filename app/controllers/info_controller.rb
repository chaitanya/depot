class InfoController < ApplicationController
  
  def who_bought
    @product = Product.find(params[:id])
    @orders = @product.orders
    respond_to do |format|
      format.html
      format.xml { render :xml=>@product.to_xml(:include=> :orders) }
    end
  end
  
  protected
  def authorize
    
  end
end
