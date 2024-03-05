# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Transaction.destroy_all
Customer.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all
Discount.destroy_all
Item.destroy_all
Merchant.destroy_all




Rake::Task["csv_load:all"].invoke
    @merchant = Merchant.all.first

    @discount_1 = Discount.create!(percentage: "10%", quantity: 10, merchant_id: @merchant.id)
    @discount_2 = Discount.create!(percentage: "20%", quantity: 20, merchant_id: @merchant.id)