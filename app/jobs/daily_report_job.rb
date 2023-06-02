require 'csv'

class DailyReportJob < ApplicationJob
  queue_as :default
  
  def perform
    purchases = Sale.where(created_at: Date.yesterday.all_day)

    # Group purchases by product and aggregate total amount
    report_data = purchases.group(:product_id).sum
    report = generate_report(report_data)

    ProductMailer.product_daily_report(admins, report).deliver_now
  end

  private

  def admins
    Account.where(type: 'admin')
  end

  def generate_report(report_data)

    CSV.generate(headers: true) do |csv|
      csv << ['Product ID', 'Total Amount']
      report_data.each do |product_id, total_amount|
        csv << [product_id, total_amount]
      end
    end
  end

end
