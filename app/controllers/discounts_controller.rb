class DiscountsController < ApplicationController
    before_action :find_discount_and_merchant, only: [:show, :edit, :update, :destroy]
    before_action :find_merchant, only: [:new, :create, :index]
    


    def index
        # @merchant = Merchant.find(params[:merchant_id])
        @discounts = @merchant.discounts
        
    end

    def show
        # @merchant = Merchant.find(params[:merchant_id])
        # @discount = Discount.find(params[:id])
        
    end


    def new

    end
  
    def create
      Discount.create!(discount_params)
      redirect_to merchant_discounts_path(@merchant)
    end

    def destroy
        @discount.destroy
        redirect_to merchant_discounts_path(@merchant)
    end

    def edit

    end

    def update
        @discount.update(discount_params)   
        redirect_to merchant_discount_path(@merchant, @discount)   
    end



    private

    def find_discount_and_merchant
        @discount = Discount.find(params[:id])
        @merchant = Merchant.find(params[:merchant_id])
      end
    
      def find_merchant
        @merchant = Merchant.find(params[:merchant_id])
      end

      def discount_params
        params.permit(:percentage, :quantity, :merchant_id)
      end

end