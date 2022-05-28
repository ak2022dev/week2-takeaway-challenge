class Menu

  attr_reader :venue_name, :dishes

  def initialize(venue_name)
    @venue_name = venue_name
    @dishes = []    
  end

  def add(dish)
    # dish names uniquely identify them
    # adding a dish with a name that is already
    # in the menu over-writes the previous entry
    if dish_names.include?(dish.name) 
      # remove old record of dish to replace with this new one
      remove!(dish.name)
    end
    @dishes << dish
#    binding.irb
  end

  def remove!(dish_name)
    # dish_name is a string to match an existing dish's name
    @dishes.each do |dish|
#      binding.irb
      if dish.name == dish_name
        @dishes.delete(dish)
#        binding.irb 
        return
      end
    end
  end

  def list_all
  end

  def dish_price(dish_name)
  end

  def dish_names
    # returns array of dish names already in menu
    names = []
    @dishes.each do |dish|
      names << dish.name
    end
    return names
  end

  def show
    # returns an array of formatted strings as such
    # [ "Take-away name", "1. First dish name: First dish description, £price" ...etc...]
    menu_strings = []
    menu_strings << @venue_name
    count = 1
    while count <= @dishes.length
#      puts "count is #{count} @dishes.length is #{@dishes.length}"
      # Add a menu number
      dish_string = ""
      dish_string.concat(count.to_s)
      dish_string.concat(". ")
      dish_string.concat(@dishes[count-1].name)
      dish_string.concat(": ")
      dish_string.concat(@dishes[count-1].description)      
      dish_string.concat(", £")
      price_string = sprintf("%04.2f", @dishes[count-1].price)
      dish_string.concat(price_string)
      menu_strings << dish_string
      count += 1
#      binding.irb
    end
    return menu_strings
  end
end
