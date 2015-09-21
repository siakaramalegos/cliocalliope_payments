class CustomerInvitation < ApplicationMailer
  def send_customer_invite(customer)
    @customer = customer
    mail(:to => @customer.email, :subject => 'Your invitation to Clio + Calliope Payments')
  end
end
