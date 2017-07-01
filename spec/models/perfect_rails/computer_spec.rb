require 'rails_helper'

RSpec.describe PerfectRails::Computer, type: :model do
  describe '#save' do
    let(:computer) { PerfectRails::Computer.new }
    it '属性値の変化を追跡できる' do
      computer.name = "Phoenix1gou"
      expect(computer.name_changed?).to be_truthy
      expect(computer.name_was).to be_nil
      expect(computer.name_change).to be_include("Phoenix1gou")
      computer.name = "Mr.PC"
      expect(computer.name_change).to be_include("Mr.PC")
      computer.save
      expect(computer.name_changed?).to be_falsey
      computer.name = "Mr.PC"
      expect(computer.name_changed?).to be_falsey
    end
  end
end