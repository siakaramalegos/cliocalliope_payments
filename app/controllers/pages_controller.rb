class PagesController < ApplicationController
  def index
    @invoices = Invoice.all
  end
end
