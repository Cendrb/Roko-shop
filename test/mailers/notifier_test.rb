require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    mail = Notifier.order_received(orders(:one))
    assert_equal "Potvrzení objednávky z obchodu Pragmatická Ivona", mail.subject
    assert_equal ["penis@gmail.com"], mail.to
    assert_equal ["Pragmatická Ivona"], mail.from
  end

  test "order_shipped" do
    mail = Notifier.order_shipped(orders(:one))
    assert_equal "Objednávka z obchodu Pragmatická Ivona byla odeslána", mail.subject
    assert_equal ["penis@gmail.com"], mail.to
    assert_equal ["Pragmatická Ivona"], mail.from
  end

end
