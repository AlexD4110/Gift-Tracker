class Friend < ApplicationRecord
  has_many :gifts, dependent: :destroy, inverse_of: :friend
  accepts_nested_attributes_for  :gifts, allow_destroy: true, reject_if: :all_blank


  # Add validations for presence of name and birthday
  validates :name, presence: true
  validates :birthday, presence: true
end
