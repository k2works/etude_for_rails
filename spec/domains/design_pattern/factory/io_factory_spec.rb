require 'rails_helper'

describe DesignPattern::Factory::IOFactory do
  describe '#new_reader' do
    it 'create html reader instance' do
      html_factory = DesignPattern::Factory::IOFactory.new('HTML')
      html_reader = html_factory.new_reader
      expect(html_reader.class).to eq(DesignPattern::Factory::HTMLReader)
    end

    it 'create pdf reader instance' do
      pdf_factory = DesignPattern::Factory::IOFactory.new('PDF')
      pdf_reader = pdf_factory.new_reader
      expect(pdf_reader.class).to eq(DesignPattern::Factory::PDFReader)
    end
  end

  describe '#new_writer' do
    it 'create html writer instance' do
      html_factory = DesignPattern::Factory::IOFactory.new('HTML')
      html_writer = html_factory.new_writer
      expect(html_writer.class).to eq(DesignPattern::Factory::HTMLWriter)
    end

    it 'create pdf writer instance' do
      pdf_factory = DesignPattern::Factory::IOFactory.new('PDF')
      pdf_writer = pdf_factory.new_writer
      expect(pdf_writer.class).to eq(DesignPattern::Factory::PDFWriter)
    end
  end
end