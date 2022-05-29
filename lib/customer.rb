class Customer
  
  attr_reader :customer_name, :order

  def initialize(customer_name)
    # dish_names is an array of dish_names from the menu
    @customer_name = customer_name
    @order = nil
  end
  def ordermeal(dishes)
    # dishes is an array of dishes
    @order = Order.new(@customer_name, dishes)
  end
  def verify_order
    return @order.produce_receipt
  end
  def add_dish(dish)
    @order.add(dish)
  end
  def remove_dish(dish)
    @order.remove(dish)
  end
end
