class Invoice < ActiveRecord::Base
  belongs_to :customer
  has_many :payments

  def description
    # TODO:  make 2 decimal places
    "#{customer.name} invoice ##{number}"
  end

  def paid?
    all_payments = 0
    payments.each {|pay| all_payments += pay.total_payment}
    if all_payments >= (total_amount * 0.029) + 0.30
      true
    else
      false
    end
  end
end
