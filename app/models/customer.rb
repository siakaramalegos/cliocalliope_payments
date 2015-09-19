class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :cards
  belongs_to :user
end
