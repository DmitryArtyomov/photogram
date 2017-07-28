require 'rails_helper'

RSpec.describe Notifications::AbstractNotification do
  context '#notify' do
    it 'raises NotImplementedError' do
      expect { described_class.new.notify }.to raise_error(NotImplementedError)
    end
  end
end
