class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only, except: [:show, :new, :create]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    if params[:invoice_id]
      @payment = Payment.new
      @invoice = Invoice.find(params[:invoice_id])
      @customer = @invoice.customer
      @merchant_fees = (@invoice.total_amount * 0.029) + 0.30
      @payment.total_payment = @invoice.total_amount + @merchant_fees
      @amount = @payment.total_payment * 100
    else
      redirect_to :root, alert: 'Please select an invoice to pay.'
    end
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    @invoice = Invoice.find(payment_params[:invoice_id])
    @customer = @invoice.customer

    token = params[:stripeToken]

    # Amount in cents
    @amount = (@payment.total_payment * 100).to_i

    customer = Stripe::Customer.create(
      :email => @customer.email,
      :description => @customer.name,
      :card => token
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => @invoice.description,
      :currency    => 'usd'
    )

    respond_to do |format|
      if @payment.save
        # TODO:  add mailer for confirmation
        format.html { redirect_to @payment, notice: 'Payment was successfully submitted.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_url
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:invoice_id, :total_payment, :notes)
    end
end
