require 'rails_helper'
RSpec.describe Invoice do
  describe 'relationhips' do
    it { should belong_to :customer }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions }
  end
end
