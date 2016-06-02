class Api::V1::InvoiceItemsController < Api::ApiController
  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with InvoiceItem.search_by(invoice_item_params)
  end

  def find_all
    respond_with InvoiceItem.find_all(invoice_item_params)
  end

  def random
    respond_with InvoiceItem.rand
  end

  def invoice
    respond_with InvoiceItem.has_invoice(params[:id])
  end

  def item
    respond_with InvoiceItem.has_item(params[:id])
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
