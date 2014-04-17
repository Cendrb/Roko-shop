require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do
    LineItem.delete_all # clear LI
    Order.delete_all # clear orders
    ruby_book = products(:ruby)
    
    # Visit index page
    get "/" # get index site
    assert_response :success # verify response
    assert_template "index" # verify content
    
    # Add item to cart
    xml_http_request :post, '/line_items', product_id: ruby_book.id # send request
    assert_response :success # verify response
    
    # Verify if item is in cart
    cart = Cart.find(session[:cart_id]) # get cart
    assert_equal 1, cart.line_items.size # verify number of items in cart
    assert_equal ruby_book, cart.line_items[0].product # is ruby book in cart?
    
    # Visit new order
    get "/orders/new" # get new order
    assert_response :success # verify response
    assert_template "new" # verify content
    
    # Send form
    post_via_redirect "/orders", order: { name: "Ivona Součková", address: "Kurví díra 69/139", email: "kurva@laris.ad", pay_type: "Korupce" } # Send POST request
    assert_response :success # verify response
    assert_template "index" # verify content
    
    # Verify items
    cart = Cart.find(session[:cart_id]) # get cart
    assert_equal 0, cart.line_items.size # verify number of items in cart
    
    # Verify order
    orders = Order.all
    assert_equal 1, orders.size # verify number of orders
    order = orders[0]
    
    # Verify data in order
    assert_equal "Ivona Součková", order.name
    assert_equal "Kurví díra 69/139", order.address
    assert_equal "kurva@laris.ad", order.email
    assert_equal "Korupce", order.pay_type
    
    # Verify items in order
    assert_equal 1, order.line_items.size # verify number of items in order
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product # verify item in order
    
    # Verify mail
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["kurva@laris.ad"], mail.to
    assert_equal ["Pragmatická Ivona"], mail.from
    assert_equal "Potvrzení objednávky z obchodu Pragmatická Ivona", mail.subject
  end
end
