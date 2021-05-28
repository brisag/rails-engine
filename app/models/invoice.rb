class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  class << self
    def unshipped_revenue(quantity)
      select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue')
      .group(:id)
      .joins(:invoice_items)
      .where(status: :packaged)
      .order(potential_revenue: :desc)
      .limit(quantity)
    end
  end
end
