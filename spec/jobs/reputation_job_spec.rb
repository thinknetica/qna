require 'rails_helper'

RSpec.describe ReputationJob, type: :job do
  let(:question) { create(:question) }

  it 'calls Services::Reputation#calculate' do
    expect(Services::Reputation).to receive(:calculate).with(question)
    ReputationJob.perform_now(question)
  end
end
