class Quote < ApplicationRecord
  belongs_to :company
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates
  
  validates :name, presence: true
  scope :ordered, -> { order(id: :desc) }

  # making the request asynchronous so that jobs are enqueued

  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend


  # Those three callbacks are equivalent to the following single line
  #  broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend

  def total_price
    line_items.sum(&:total_price)
  end
end
