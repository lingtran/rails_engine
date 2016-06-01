class Api::V1::CustomersController < Api::ApiController
  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    respond_with Customer.search_by(customer_params)
  end

  def find_all
    respond_with Customer.find_all(customer_params)
  end

  def random
    respond_with Customer.rand
  end

  def invoices
    respond_with Customer.find(params[:id]).invoices
  end

  private
    def customer_params
      params.permit(:first_name, :last_name, :created_at, :updated_at)
    end
end
