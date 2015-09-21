class Admin < ApplicationMailer
  def notify_new_user(admin, user)
    unless admin == nil
      @admin = admin
      @user = user
      mail(:to => @admin.email, :subject => 'A new user has signed up for Clio + Calliope Payments')
    end
  end
end
