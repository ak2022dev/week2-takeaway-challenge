{{PROBLEM}} Multi-Class Planned Design Recipe
1. Implement a system to support a take-away for food orders etc


    As a customer
    So that I can check if I want to order something
    I would like to see a list of dishes with prices.

    As a customer
    So that I can order the meal I want
    I would like to be able to select some number of several available dishes.

    As a customer
    So that I can verify that my order is correct
    I would like to see an itemised receipt with a grand total.

(To add later)

Use the twilio-ruby gem to implement this next one. You will need to use doubles too.

    As a customer
    So that I am reassured that my order will be delivered on time
    I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.

Fair warning: if you push your Twilio API Key to a public Github repository, anyone will be able to see and use it. What are the security implications of that? How will you keep that information out of your repository?


2. Design the Class System

./take-away-design.dia for class diagrams

Also design the interface of each class in more detail.

class Customer  # TODO update diagram
  def place_order(menu)
    # returns an order
  end
  def verify_order  # should receipt be a separate object?
    # produces itemised receipt
  end
  def add_dish(name)
  end
  def remove_dish(name)
  end
end


class Order  # TODO update diagram
  def initialize(customer_name, items)
    # items is an array of dish names
  end
  def add(dish_name)
  end
  def remove(dish_name)
  end
  def produce_receipt
    # itemised including grand total
  end
end


class Menu  # TODO update diagram

  def initialize(venue_name)    
  end

  def venue
    # returns name of venue
  end

  def add(dish)
    # dish names uniquely identify them
    # adding a dish with a name that is already
    # in the menu over-writes the previous entry
  end

  def remove(dish_name)
  end

  def list_all
  end

  def dish_price(dish_name)
  end

end


class Dish  # TODO update diagram

  def initialize(name, description, price)
    # name should be unique
  end

  def name
  end

  def description
  end

  def price
    # float, unit pounds
  end

end


3. Create Examples as Integration Tests

Create examples of the classes being used together in different situations and combinations that reflect the ways in which the system will be used.

# Menu remembers name of its venue after construction
menu = Menu.new("Khan's Hot-stuff Take-away")
menu.venue_name => "Khan's Hot-stuff Take-away"
menu.dishes => []
# Menu can be built by adding dishes
dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
menu.add(dish1)
menu.add(dish2)
# Menu can display itself
menu.show => ["Khan's Hot-stuff Take-away", "1. Burger: A vegan burger in a vegan bap, £3.50", "2. Chips: British potato chips fried in vegetable oil, £2.00"]
# Dishes can be deleted from menu by name
menu.remove(dish2.name)
menu.show => ["Khan's Hot-stuff Take-away", "1. Burger: A vegan burger in a vegan bap, £3.50"]
menu.remove(dish1.name)
menu.show => ["Khan's Hot-stuff Take-away"]
# TODO adding a dish to menu if one with same name already there?
# Asking to delete dishes not in menu is ignored
menu.delete("non-existent name")
menu.show => ["Khan's Hot-stuff Take-away"]


# New order remembers name of customer when created
menu = Menu.new("Khan's Hot-stuff Take-away")
dish1 = Dish.new("Burger", "A vegan burger in a vegan bap", 3.50)
dish2 = Dish.new("Chips", "British potato chips fried in vegetable oil", 2.00)
menu.add(dish1)
menu.add(dish2)
order = Order.new("Customer_name", ["Burger"])
# New order remembers list of dishes ordered by name
order.customer_name => "Customer_name
order.dish_names => ["Burger"]
# Dishes can be added by name to an existing order
order.add("Chips")
order.dish_names_ => ["Burger", "Chips"]
# Dishes can be ordered multiple times on same order
order.add("Chips")
order.dish_names => ["Burger", "Chips", "Chips"]
# If a dish is deleted from an order, only one instance of it is deleted if there is more than one on the order
order.remove("Chips")
order.dishes => ["Burger", "Chips"]
# All items can be removed from an order if customer decides doesn't want to dine
order.remove("Burger")
order.remove("Chips")
order.dishes => []
order.grand_total => 0.00
# A customer can create an order including their name
# TODO customer = Customer.new("Customer1", ["Burger","Chips"])

# A customer can verify their order by receiving an itemised receipt
customer.verify_order => ["Burger £3.50 + Chips £2.00 = Total £5.50]



4. Create Examples as Unit Tests

Create examples, where appropriate, of the behaviour of each relevant class at a more granular level of detail.

# EXAMPLE

# Dish class
dish = Dish.new("Burger", "A vegan burger in a vegan bap", "3.50")
dish.name => "Burger"
dish.description => "A vegan burger in a vegan bap"
dish.price => 3.50


# Constructs a track

5. Implement the Behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.