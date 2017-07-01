class PerfectRails::Person2
  include ActiveModel::AttributeMethods

  attribute_method_affix prefix: 'reset_', suffix: '_to_default!'
  attribute_method_suffix '_contrived?'
  attribute_method_prefix 'clear_'
  define_attribute_method :name
  attr_accessor :name

  def attributes
    { 'name' => @name }
  end

  private

  def attribute_contrived?(attr)
    true
  end

  def clear_attribute(attr)
    send("#{attr}=", nil)
  end

  def reset_attribute_to_default!(attr)
    send("#{attr}=", 'Default Name')
  end
end