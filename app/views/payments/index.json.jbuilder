json.array!(@payments) do |payment|
  json.extract! payment, :id, :invoice_id, :total_payment, :notes
  json.url payment_url(payment, format: :json)
end
