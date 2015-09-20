class PagesController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        @invoices = Invoice.all
      else
        @invoices = Invoice.where(customer_id: current_user.customer.id)
      end
      @invoices = @invoices.sort_by{ |x| x.paid? ? 0 : 1 }.reverse!
    end
  end
end
