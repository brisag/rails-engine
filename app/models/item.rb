class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  def self.ranked_by_revenue(quantity)
      joins(:transactions)
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .group(:id)
      .where('transactions.result = ?', 'success')
      .order(revenue: :desc)
      .limit(quantity)
  end
end
