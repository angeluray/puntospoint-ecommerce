class ProductMailer < ApplicationMailer
    def product_first_sale_notification(creator, admins, product, sale)
        @creator = creator
        @admins = admins
        @product = product
        @sale = sale
    
        mail(to: creator.email, cc: admins.pluck(:email), subject: "First sale of #{product.name}")
    end

    def product_daily_report(admins, report)
      @report = report
      mail(to: admins.pluck(:email), subject: 'Daily Products Report')
    end
end
