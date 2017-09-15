require 'rails_helper'

RSpec.describe NotificationJob, type: :job do
  describe "#perform_later" do
    let(:message) { Message.new(body: 'Hello world!') }

    it "save message" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        NotificationJob.perform_later(message.save)
      }.to have_enqueued_job
    end
  end
end
