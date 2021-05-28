class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.unshipped_revenue(quantity)
    select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue')
    .joins(:invoice_items)
    .where(status: :packaged)
    .group(:id)
    .order(potential_revenue: :desc)
    .limit(quantity)
  end
end
