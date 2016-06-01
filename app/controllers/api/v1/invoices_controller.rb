class Api::V1::InvoicesController < Api::ApiController
  def index
    respond_with Invoices.all
  end

  def show
    respond_with Invoices.find_by(id: params[:id])
  end
end
