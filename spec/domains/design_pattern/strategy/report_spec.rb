require 'rails_helper'

describe DesignPattern::Strategy::Report do
  describe '#output_report' do
    context 'format is HTML' do
      it 'output' do
        report = DesignPattern::Strategy::Report.new(DesignPattern::Strategy::HTMLFormatter.new)
        expected = <<-EOS
<html>
  <head>
    <title>月次報告</title>
  </head>
  <body>
    <p>順調</p>
    <p>最高の調子</p>
  </body>
</html>
        EOS

        expect { report.output_report }.to output(expected).to_stdout
      end
    end

    context 'format is Plain text' do
      it 'output' do
        report = DesignPattern::Strategy::Report.new(DesignPattern::Strategy::PlainTextFormatter.new)
        expected = <<-EOS
**** 月次報告 ****
順調
最高の調子
        EOS

        expect { report.output_report }.to output(expected).to_stdout
      end
    end
  end
end
