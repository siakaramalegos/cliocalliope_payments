class CustomerInvitation < ApplicationMailer
  def send_customer_invite(customer)
    @customer = customer
    mail(:to => @customer.email, :subject => 'Your invitation to Clio + Calliope Payments')
  end

  def send_link_notify(user_id)
    @user = User.find(user_id)
    @customer = @user.customer
    mail(:to => @customer.email, :subject => 'Your payments account is now linked')
  end

  # def notify_new_invoice(customer, invoice)
  #   @customer = customer
  #   @invoice = invoice
  #   mail(:to => @customer.email, :subject => 'You have a new Clio + Calliope invoice')
  # end
end
