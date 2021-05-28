class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def revenue
    transactions
    .where('transactions.result = ?', 'success')
    .where('invoices.status = ?', 'shipped')
    .pluck('sum(invoice_items.unit_price * invoice_items.quantity)')
    .first
  end

  class << self
    def search_criteria(name)
      where("name ILIKE ?", "%#{name}%")
      .order(:name)
    end

    def merchants_with_most_revenue(quantity)
      select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
      .joins(:transactions)
      .where('transactions.result = ?', 'success')
      .where('invoices.status = ?', 'shipped')
      .group(:id)
      .order(total_revenue: :desc)
      .limit(quantity)
    end
  end
end
