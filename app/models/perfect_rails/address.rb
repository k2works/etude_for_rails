class PerfectRails::Address
  attr_accessor :prefecture, :city, :house_number

  def initialize(prefecture = nil, city = nil, house_number = nil)
    @prefecture = prefecture
    @city = city
    @house_number = house_number
  end

  def hash
    prefecture.hash + city.hash + house_number.hash
  end

  def ==(other)
    return false unless other.is_a?(PerfectRails::Address)

    same_prefecture?(other) && same_city?(other) && same_house_number?(other)
  end

  def same_prefecture?(other)
    prefecture == other.prefecture
  end

  def same_city?(other)
    city == other.city
  end

  def same_house_number?(other)
    house_number == other.house_number
  end
end
