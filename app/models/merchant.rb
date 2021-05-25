class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.search_by_name(name)
    where("name ILIKE '%#{name}%'").order(:name)
  end

  # Merchant.joins(:transactions).where('transactions.result = ?', 'success').where('invoices.status = ?', 'shipped').select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue').group(:id)
  # Merchant.joins(:transactions).where('transactions.result = ?', 'success').where('invoices.status = ?', 'shipped').select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity)').group(:id).first
  # Merchant.joins(:transactions).where('transactions.result = ?', 'success').where('invoices.status = ?', 'shipped').select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue').group(:id).order(total_revenue: :desc)
  # Merchant.joins(:transactions).where('transactions.result = ?', 'success').where('invoices.status = ?', 'shipped').pluck('sum(invoice_items.unit_price * invoice_items.quantity)').first
  def revenue
    transactions
    .where('transactions.result = ?', 'success')
    .where('invoices.status = ?', 'shipped')
    .pluck('sum(invoice_items.unit_price * invoice_items.quantity)')
    .first
  end
end


    # .merge(Transaction.successful)
    # .merge(Invoice.shipped)
    # .sum('invoice_items.unit_price * invoice_items.quantity')
    # .where('transactions.result = ?', 'success')
    # .where('invoices.status = ?', 'shipped')
    # .pluck('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
    # .first.to_float
    # .group(:id)

    # http://localhost:3000/api/v1/revenue/merchants/{{merchant_id}}


    # transaction = successful
    # invoice = shipped or packaged
    # invoice_items = quantity * unit price
