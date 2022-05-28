class Order
  attr_reader :dish_names, :customer_name

  def initialize(customer_name, items)
    # items is an array of dish names
    @customer_name = customer_name
    @dish_names = []
    items.each do |dish_name|
      add(dish_name)
    end
  end

  def add(dish_name)
    @dish_names << dish_name
  end

  def remove(dish_name)
    # dish_name is present in the order
    @dish_names.delete_at(@dish_names.find_index(dish_name))
  end
  def produce_receipt
    # itemised including grand total
  end
end
