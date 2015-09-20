class Payment < ActiveRecord::Base
  belongs_to :invoice
  # TODO:  Make it so either invoice_id or notes is required
end
