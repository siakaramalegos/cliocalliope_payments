class Invoice < ActiveRecord::Base
  belongs_to :customer
  has_many :payments

  def description
    # TODO:  make 2 decimal places
    "#{customer.name} invoice ##{number}"
  end
end
