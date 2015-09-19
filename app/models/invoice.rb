class Invoice < ActiveRecord::Base
  belongs_to :customer
  has_many :payments

  def description
    # TODO:  make 2 decimal places
    "#{number}: #{customer.name} $#{total_amount} USD due #{due_date}"
  end
end
