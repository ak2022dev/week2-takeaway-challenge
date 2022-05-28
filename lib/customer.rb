class Customer

  def initialize(customer_name, dish_names)
    # dish_names is an array of dish_names from the menu
    @customer_name = customer_name
    @order = Order.new(customer_name, dish_names)
  end
#  def ordermeal(dish_names)
    # returns an order
#  end
  def verify_order  # should receipt be a separate object?
    # produces itemised receipt
  end
  def add_dish(name)
  end
  def remove_dish(name)
  end
end
