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

      it 'cant build when memory size less than 250' do
        builder = DesignPattern::Builder::DeskTopBuilder.new
        builder.memory_size(249)

        expect { builder.computer }.to raise_error(RuntimeError, "Not enough memory")
      end

      it 'cant build when drive more than 5' do
        builder = DesignPattern::Builder::DeskTopBuilder.new
        builder.add_cd(true)
        builder.add_dvd
        3.times.each { builder.add_hard_disk(100000)}

        expect { builder.computer }.to raise_error(RuntimeError, "Too many drives")
      end

      it 'cant build when no hard disk' do
        builder = DesignPattern::Builder::DeskTopBuilder.new
        builder.add_cd(true)
        builder.add_dvd

        expect { builder.computer }.to raise_error(RuntimeError, "No hard disk.")
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

      it 'cant build when memory size less than 500' do
        builder = DesignPattern::Builder::LaptopBuilder.new
        builder.memory_size(499)

        expect { builder.computer }.to raise_error(RuntimeError, "Not enough memory")
      end

      it 'cant build when drive more than 4' do
        builder = DesignPattern::Builder::LaptopBuilder.new
        builder.add_dvd
        3.times.each { builder.add_hard_disk(100000)}

        expect { builder.computer }.to raise_error(RuntimeError, "Too many drives")
      end

      it 'cant build when no hard disk' do
        builder = DesignPattern::Builder::LaptopBuilder.new
        builder.add_dvd

        expect { builder.computer }.to raise_error(RuntimeError, "No hard disk.")
      end

      it 'can reuse builder' do
        builder = DesignPattern::Builder::LaptopBuilder.new
        builder.turbo
        builder.add_hard_disk(100000)
        computer1 = builder.computer

        builder.reset
        builder.turbo
        builder.add_hard_disk(100000)
        computer2 = builder.computer

        expect(computer1).not_to eq(computer2)
      end
    end
  end
end