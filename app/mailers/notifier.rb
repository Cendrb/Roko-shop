class Notifier < ActionMailer::Base
  default from: "Pragamatická Ivona"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order

    mail to: order.email, subject: 'Potvrzení objednávky z obchodu Pragmatická Ivona'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped
    @order = order

    mail to: order.email, subject: 'Objednávka z obchodu Pragmatická Ivona byla odeslána'
  end
end
