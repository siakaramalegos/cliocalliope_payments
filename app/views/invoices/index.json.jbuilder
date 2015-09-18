json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :number, :customer_id, :invoice_date, :due_date, :total_amount
  json.url invoice_url(invoice, format: :json)
end
