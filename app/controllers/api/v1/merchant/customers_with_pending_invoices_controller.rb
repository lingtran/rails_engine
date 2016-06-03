class Api::V1::Merchant::CustomersWithPendingInvoicesController < Api::ApiController
  def index
    respond_with ::Merchant.customers_with_pending_invoices_for_merchant(merchant_params[:id].to_i)
  end

  private
  def merchant_params
    params.permit(:id)
  end
end
