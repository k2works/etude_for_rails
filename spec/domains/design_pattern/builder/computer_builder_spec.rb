require 'rails_helper'

describe DesignPattern::Builder::ComputerBuilder do
  describe '#computer' do
    context 'Using DesktopBuilder' do
      it 'build desktop computer' do
        builder = DesignPattern::Builder::DeskTopBuilder.new
        builder.turbo
        builder.add_cd(true)
        builder.add_dvd
        builder.add_hard_disk(100000)
        computer = builder.computer

        expect(computer.motherboard.cpu.class).to eq(DesignPattern::Builder::TurboCPU)
        expect(computer.drives.first.type).to eq(:cd)
        expect(computer.drives.first.size).to eq(760)
        expect(computer.drives.first.writable).to be true
        expect(computer.drives.second.type).to eq(:dvd)
        expect(computer.drives.second.size).to eq(4000)
        expect(computer.drives.second.writable).to be false
        expect(computer.drives.third.type).to eq(:hard_disk)
        expect(computer.drives.third.size).to eq(100000)
        expect(computer.drives.third.writable).to be true
      end
    end

    context 'Using LaptopBuilder' do
      it 'build laptop computer' do
        builder = DesignPattern::Builder::LaptopBuilder.new
        builder.turbo
        builder.add_cd(true)
        builder.add_dvd
        builder.add_hard_disk(100000)
        computer = builder.computer

        expect(computer.motherboard.cpu.class).to eq(DesignPattern::Builder::TurboCPU)
        expect(computer.drives.first.type).to eq(:cd)
        expect(computer.drives.first.size).to eq(760)
        expect(computer.drives.first.writable).to be true
        expect(computer.drives.second.type).to eq(:dvd)
        expect(computer.drives.second.size).to eq(4000)
        expect(computer.drives.second.writable).to be false
        expect(computer.drives.third.type).to eq(:hard_disk)
        expect(computer.drives.third.size).to eq(100000)
        expect(computer.drives.third.writable).to be true
      end

      it 'cant build crt display' do
        builder = DesignPattern::Builder::LaptopBuilder.new

        expect { builder.display = :crt }.to raise_error(RuntimeError, "Laptop display must be lcd")
      end
    end
  end
end