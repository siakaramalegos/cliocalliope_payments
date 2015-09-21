class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:users]
  before_action :admin_only, only: [:users]

  def index
    if user_signed_in?
      if current_user.admin?
        @invoices = Invoice.all
      else
        @invoices = Invoice.where(customer_id: current_user.customer.try(:id))
      end
      @invoices = @invoices.sort_by{ |x| x.paid? ? 0 : 1 }.reverse!
    end
  end

  def users
    @users = User.order(:name)
  end
end
