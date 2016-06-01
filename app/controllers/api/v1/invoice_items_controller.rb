class Api::V1::InvoiceItemsController < Api::ApiController
  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end
end
