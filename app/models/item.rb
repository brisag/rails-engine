class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  class << self
    def ranked_by_revenue(quantity)
        joins(:transactions)
        .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
        .group(:id)
        .where('transactions.result = ?', 'success')
        .order(revenue: :desc)
        .limit(quantity)
    end

    def search_criteria(name)
      where("lower(name) LIKE '%#{name}%'").order(:name)
    end

    def search_by_min_price(min_price)
      where('unit_price >= ?', "#{min_price}").order(:name).first
    end

    def search_by_max_price(max_price)
      where('unit_price <= ?', "#{max_price}").order(:name).first
    end

    def min_max_search(min_price, max_price)
      if min_price.present? && max_price.present?
        where('unit_price between ? and ?', "#{min_price}", "#{max_price}").order(:name).first
      else
        max_price.nil? && min_price.nil?
        return search_by_max_price("#{max_price}") unless max_price.nil?
        return search_by_min_price("#{min_price}") unless min_price.nil?
      end
    end
  end
end
