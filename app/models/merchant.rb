class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  # def self.search_criteria(name)
  #   where("name ILIKE ?", "%#{name}%")
  #   .order(:name)
  # end

  # def self.search_criteria(name)
  #   where("name ilike ?", "%#{name}%")
  #   .order(:name)
  # end

  def self.merchants_with_most_revenue(quantity)
    # binding.pry
    select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
    .joins(:transactions)
    .where('transactions.result = ?', 'success')
    .where('invoices.status = ?', 'shipped')
    .group(:id)
    .order(total_revenue: :desc)
    .limit(quantity)
  end

  def self.unshipped_revenue(quantity)
    joins(:invoices)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as potential_revenue')
    .group(:id)
    .where(status: :packaged)
    .order(potential_revenue: :desc)
    .limit(quantity)
  end

  # def self.merchants_with_most_revenue(quantity)
  #   select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue')
  #   .joins(:transactions)
  #   .where('transactions.result = ?', 'success')
  #   .where('invoices.status = ?', 'shipped')
  #   .group(:id)
  #   .order(total_revenue: :desc)
  #   .limit(quantity)
  # end


  def revenue
    transactions
    .where('transactions.result = ?', 'success')
    .where('invoices.status = ?', 'shipped')
    .pluck('sum(invoice_items.unit_price * invoice_items.quantity)')
    .first
  end
end
