require 'menu'
require 'dish'
require 'order'
require 'customer'

RSpec.describe "integration" do

  context "Menu class and its interactions" do
    it "Remembers venue name of newly created menu" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      expect(menu.venue_name).to eq "Khan's Hot-stuff Take-away"
      expect(menu.dishes).to eq []
    end
    it "can build a menu by adding dishes" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      expect(menu.show).to eq ["Khan's Hot-stuff Take-away", "1. Burger: A vegan burger in a vegan bap, £3.50", "2. Chips: British potato chips fried in vegetable oil, £2.00"]
    end
    it "can delete dishes" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      menu.remove!(dish2.name)
      expect(menu.show).to eq ["Khan's Hot-stuff Take-away", "1. Burger: A vegan burger in a vegan bap, £3.50"]
      menu.remove!(dish1.name)
      expect(menu.show).to eq ["Khan's Hot-stuff Take-away"]      
    end
    it "can ignore request to delete dish not in menu" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      menu.remove!("Not on menu")
      expect(menu.show).to eq ["Khan's Hot-stuff Take-away"]      
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      menu.add(dish1)
      expect(menu.show).to eq ["Khan's Hot-stuff Take-away", "1. Burger: A vegan burger in a vegan bap, £3.50"]      
    end
    # TODO add test that dish with same name as existing dish in
    # Menu replaces it, e.g. to change description
    it "can update an entry for an existing item by re-adding it" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      menu.add(dish1)
      expect(menu.show).to eq ["Khan's Hot-stuff Take-away", "1. Burger: A vegan burger in a vegan bap, £3.50"]      
      # TODO complete this!
      dish2 = Dish.new("Burger", "A beef burger in a bap", 4.50)
      menu.add(dish2)
      expect(menu.show).to eq ["Khan's Hot-stuff Take-away", "1. Burger: A beef burger in a bap, £4.50"]      
    end
  end

  context "Customer, order and menu interactions" do
    it "remembers name of customer and list of dishes when new order created" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      menu.add(dish1)
      order = Order.new("Customer_name", [dish1])
      expect(order.customer_name).to eq "Customer_name"
      expect(order.dishes).to eq [dish1]
    end
    it "allows dishes to be added to an existing order" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", [dish1])
      order.add(dish2)
      expect(order.dishes).to eq [dish1, dish2]
    end
    it "allows dishes with the same name to be added more than once within an order" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", [dish1])
      order.add(dish2)
      order.add(dish2)
      expect(order.dishes).to eq [dish1, dish2, dish2]
    end
    it "remove only removes one at a time for dishes with the same ordered more than once" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", [dish1])
      order.add(dish2)
      order.add(dish2)
      order.remove(dish2)
      expect(order.dishes).to eq [dish1, dish2]
    end
    it "can remove all orders if a customer no-longer wishes to dine" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", [dish1])
      order.add(dish2)
      order.add(dish2)
      order.remove(dish2)
      order.remove(dish2)
      order.remove(dish1)
      expect(order.dishes).to eq []
    end
    it "can allow a customer to create an order including their name" do
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)    
      customer = Customer.new("Customer1")
      customer.ordermeal([dish1, dish2])
      expect(customer.order.dishes).to eq [dish1, dish2]
    end
    it "can allow a customer to add a dish to an existing order" do
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)    
      customer = Customer.new("Customer1")
      customer.ordermeal([dish1, dish2])
      expect(customer.order.dishes).to eq [dish1, dish2]
      customer.add_dish(dish2)
      expect(customer.order.dishes).to eq [dish1, dish2, dish2]
    end
    it "can allow a customer to remove a dish from an existing order" do
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)    
      customer = Customer.new("Customer1")
      customer.ordermeal([dish1, dish2])
      customer.remove_dish(dish2)
      expect(customer.order.dishes).to eq [dish1]
    end
    it "can allow a customer to verify their order by producing an itemised receipt" do
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)    
      customer = Customer.new("Customer1")
      customer.ordermeal([dish1, dish2])
      expect(customer.verify_order).to eq "Burger £3.50 + Chips £2.00 = Total £5.50"
    end
  end
end
