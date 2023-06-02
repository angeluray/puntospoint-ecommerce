# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create admins
admin_a = Admin.create(first_name: "Angel", last_name: "Uray", username: "admin4", role_level: 0, email: "aeuraycampos@gmail.com", password: "Test123$", password_confirmation: "Test123$")
admin_f = Admin.create(first_name: "John", last_name: "Doe", username: "admin1", role_level: 0, email: "john.doe@example.com", password: "Test123$", password_confirmation: "Test123$")
admin_s = Admin.create(first_name: "Megan", last_name: "Ho Lee", username: "admin2", role_level: 1, email: "megan.h@megan.com", password: "Test123$", password_confirmation: "Test123$")
admin_t = Admin.create(first_name: "Dylan", last_name: "Messer", username: "admin3", role_level: 2, email: "dylan.m@dylan.com", password: "Test123$", password_confirmation: "Test123$")

# Create customers
customer_f = Customer.create(first_name: "Maria", last_name: "Lopez", address: "Address 1, Apt 1, Street 1", balance: "200.0", email: "maria.lopez@example.com", password: "Test123$", password_confirmation: "Test123$")
customer_s = Customer.create(first_name: "Mel", last_name: "Dolle", address: "Address 2, Apt 2, Street 2", balance: "250.7", email: "mel.dolle@example.com", password: "Test123$", password_confirmation: "Test123$")
customer_t = Customer.create(first_name: "Antoine", last_name: "Directre", address: "Address 3, Apt 3, Street 3", balance: "1250.0", email: "ant.direct@example.com", password: "Test123$", password_confirmation: "Test123$")
customer_iv = Customer.create(first_name: "Franchesco", last_name: "Juvenal", address: "Address 4, Apt 4, Street 4", balance: "800.2", email: "franchesco.juvenal@example.com", password: "Test123$", password_confirmation: "Test123$")
customer_v = Customer.create(first_name: "Molly", last_name: "Leave", address: "Address 5, Apt 5, Street 6", balance: "60.0", email: "molly.leave@example.com", password: "Test123$", password_confirmation: "Test123$")
customer_v1 = Customer.create(first_name: "Mickel", last_name: "Dollan", address: "Address 6, Apt 6, Street 6", balance: "325.7", email: "mic.dollan@example.com", password: "Test123$", password_confirmation: "Test123$")

# Create categories

## Belong to admin1
cat1 = Category.create(name: "Science artefacts", account_id: admin_f.id)
cat2 = Category.create(name: "Home", account_id: admin_f.id)
cat3 = Category.create(name: "Sports", account_id: admin_f.id)
cat4 = Category.create(name: "Women care", account_id: admin_f.id)
cat5 = Category.create(name: "Men care", account_id: admin_f.id)

## Belong to admin2
cat6 = Category.create(name: "Clothes", account_id: admin_s.id)
cat7 = Category.create(name: "Shoes", account_id: admin_s.id)
cat8 = Category.create(name: "Kids", account_id: admin_s.id)
cat9 = Category.create(name: "Digital produtcs", account_id: admin_s.id)
cat10 = Category.create(name: "School and College", account_id: admin_s.id)

# Create a new Product record with associated Image records
product1 = Product.create(name: "Product 1", description: "A new product", price: "19.99", product_stocks: 100, account_id: admin_f.id)
image1 = product1.images.build(name: "Image_1", url: "https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup.png?v=1578631807")
image2 = product1.images.build(name: "Image_2", url: "https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup.png?v=1578631807")

# Associate the Product with the Category using a new ProductCategorization record
ProductCategorization.create(product_id: product1.id, category_id: cat2.id)

#### Create a new Product record with associated Image records for Angel
product2 = Product.create(name: "Product angel", description: "A new angel product", price: "5.99", product_stocks: 100, account_id: admin_a.id)
image3 = product2.images.build(name: "Image_1", url: "https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup.png?v=1578631807")
image4 = product2.images.build(name: "Image_2", url: "https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup.png?v=1578631807")

#### Associate the Product with the Category using a new ProductCategorization record for Angel
ProductCategorization.create(product_id: product2.id, category_id: cat1.id)

#### Create a Sale(Purchase) for Angel's product
Sale.create(category_id: cat1.id, account_id: customer_f.id, admin_id: product2.account_id, product_id: product2.id, product_amount: 20)

# Create additional Products and associate them with Categories
admin_id = rand(1..2)

17.times do |i|
  price = BigDecimal(rand(1..10000) / 800.0, 2)
  product = Product.create(name: "Product #{i+2}", description: "A new product", price: "#{price}", product_stocks: 100, account_id: admin_id)
  image = product.images.build(name: "Image", url: "https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup.png?v=1578631807")
  image = product.images.build(name: "Image", url: "https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup.png?v=1578631807")
  product.save
  ProductCategorization.create(product_id: product.id, category_id: 2)
end
  
18.times do |i|
  price = BigDecimal(rand(1..10000) / 500.0, 2)
  product = Product.create(name: "Product #{i+17}", description: "A new product", price: "#{price}", product_stocks: 100, account_id: admin_id)
  image = product.images.build(name: "Image", url: "https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png")
  image = product.images.build(name: "Image", url: "https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png")
  product.save
  ProductCategorization.create(product_id: product.id, category_id: 3)
end
  
40.times do |i|
  price = BigDecimal(rand(1..10000) / 300.0, 2)
  product = Product.create(name: "Product #{i+32}", description: "A new product", price: "#{price}", product_stocks: 100, account_id: admin_id)
  image = product.images.build(name: "Image", url: "https://www.careeraddict.com/uploads/article/60419/entrepreneurship-product-ideas.png")
  image = product.images.build(name: "Image", url: "https://www.careeraddict.com/uploads/article/60419/entrepreneurship-product-ideas.png")
  product.save
  category_id = rand(4..10)
  ProductCategorization.create(product_id: product.id, category_id: category_id)
end