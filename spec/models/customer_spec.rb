require 'rails_helper'
RSpec.describe Customer do
  describe 'relationhips' do
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:merchants).through(:items) }
  end
end
