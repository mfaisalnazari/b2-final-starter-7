class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_revenue
    total_revenue - total_discount_amount
  end


  # def total_discount_amount
  #   discounted_revenue = 0
  
  #   applicable_discounts = Discount.joins(merchant: { items: :invoice_items })
  #                                   .where(invoice_items: { invoice_id: id })
  #                                   .where('discounts.quantity <= invoice_items.quantity')
  #                                   .group('invoice_items.id')
  #                                   .maximum(:percentage)
                                    
  #   # binding.pry
  #   invoice_items.each do |invoice_item|
  #     discount_percentage = applicable_discounts[invoice_item.id]
  #     if discount_percentage
  #       discounted_revenue += (discount_percentage.to_f / 100) * invoice_item.quantity * invoice_item.unit_price
  #     end
  #   end
  
  #   discounted_revenue
  # end  


  def total_discount_amount
    discounted_revenue = 0
    applicable_discounts = {}
  
    invoice_items.each do |invoice_item|
      applicable_discounts[invoice_item.id] = Discount.joins(merchant: :items)
                                                      .where(items: { id: invoice_item.item_id })
                                                      .where('discounts.quantity <= ?', invoice_item.quantity)
                                                      .pluck(:percentage) 
    end
    # binding.pry
    invoice_items.each do |invoice_item|
      max_discount_percentage = applicable_discounts[invoice_item.id].map { |percentage| percentage.delete('%').to_i }.max
      if max_discount_percentage
    
        discounted_revenue += (max_discount_percentage.to_f / 100) * invoice_item.quantity * invoice_item.unit_price
      end
    end
  
    discounted_revenue
  end
  
end
