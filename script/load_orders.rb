Order.transaction do
  (1..100).each do |i|
    Order.create(name: "Zákazník #{i}", address: "Kurva #{i}", email: "Zákazník #{i}",pay_type: "Korupce")
  end
end