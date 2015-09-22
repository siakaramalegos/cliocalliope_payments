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

  def link_notify
    CustomerInvitation.send_link_notify(params[:user_id]).deliver_now
    redirect_to :back, notice: 'Customer was notified of link.'
  end
end
