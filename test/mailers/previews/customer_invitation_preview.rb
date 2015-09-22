# Preview all emails at http://localhost:3000/rails/mailers/customer_invitation
class CustomerInvitationPreview < ActionMailer::Preview
  def send_customer_invite
    CustomerInvitation.send_customer_invite(Customer.first)
  end
end
