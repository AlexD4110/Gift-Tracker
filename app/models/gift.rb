class Gift < ApplicationRecord
  belongs_to :friend

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :link, presence: true
end
