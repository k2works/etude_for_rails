require 'rails_helper'
include DesignPattern

describe DesignPattern::TemplateMethod::Report do
  describe '#output_report' do
    it 'output html' do
      report = DesignPattern::TemplateMethod::Report.new
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
end