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
    it "can delete dishes by name" do
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
  end
  context "Customer, order and menu interactions" do
    it "remembers name of customer and list of dishes when new order created" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", ["Burger"])
      expect(order.customer_name).to eq "Customer_name"
      expect(order.dish_names).to eq ["Burger"]
    end
    it "allows dishes to be added by name for an existing order" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", ["Burger"])
      order.add("Chips")
      expect(order.dish_names).to eq ["Burger", "Chips"]
    end
    it "allows dishes with the same name to be added more than once within an order" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", ["Burger"])
      order.add("Chips")
      order.add("Chips")
      expect(order.dish_names).to eq ["Burger", "Chips", "Chips"]
    end
    it "remove only removes one at a time for dishes with the same ordered more than once" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", ["Burger"])
      order.add("Chips")
      order.add("Chips")
      order.remove("Chips")
      expect(order.dish_names).to eq ["Burger", "Chips"]
    end
    it "can remove all orders if a customer no-longer wishes to dine" do
      menu = Menu.new("Khan's Hot-stuff Take-away")
      dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
      dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
      menu.add(dish1)
      menu.add(dish2)
      order = Order.new("Customer_name", ["Burger"])
      order.add("Chips")
      order.add("Chips")
      order.remove("Chips")
      order.remove("Chips")
      order.remove("Burger")
      expect(order.dish_names).to eq []
    end
    it "can allow A customer can create an order including their name" do
      customer = Customer.new("Customer1")
      customer.ordermeal(["Burger","Chips"])
    end
    xit "can allow a customer to verify their order by producing an itemised receipt" do
      customer = Customer.new("Customer1")
      customer.ordermeal(["Burger","Chips"])
      # A customer can verify their order by receiving an itemised receipt
      expect(customer.verify_order).to eq "Burger £3.50 + Chips £2.00 = Total £5.50"
    end
  end
end
