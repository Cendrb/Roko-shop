class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Převod", "Kreditní karta", "Dobírka", "Korupce" ]
end
