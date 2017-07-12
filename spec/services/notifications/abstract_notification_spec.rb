require 'rails_helper'

RSpec.describe Notifications::AbstractNotification do
  context 'tried to instantiate' do
    it 'raises NotImplementedError' do
      expect { described_class.new }.to raise_error(NotImplementedError)
    end
  end
end
