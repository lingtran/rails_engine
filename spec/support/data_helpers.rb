module DataHelpers
  attr_reader :merchant_one,
              :merchant_two,
              :customer_one,
              :customer_two,
              :item_one,
              :item_two,
              :item_three,
              :item_four,
              :item_five,
              :invoice_one,
              :invoice_two,
              :invoice_three,
              :invoice_item_one,
              :invoice_item_two,
              :invoice_item_three,
              :invoice_item_four,
              :invoice_item_five,
              :trans_one,
              :trans_two,
              :trans_three

  def load_associations
    create_merchants
    create_customers
    create_items
    create_invoices
    create_invoice_items
    create_transactions
  end

  def create_merchants
    @merchant_one, @merchant_two = create_list(:merchant, 2)
  end

  def create_customers
    @customer_one, @customer_two = create_list(:customer, 2)
  end

  def create_items
    @item_one, @item_two, @item_three, @item_four, @item_five = create_list(:item, 5)

    [@item_one, @item_two].each { |item| @merchant_one.items << item }

    [@item_three, @item_four, @item_five].each { |item| @merchant_two.items << item }
  end

  def create_invoices
    @invoice_one, @invoice_two, @invoice_three = create_list(:invoice, 3)

    [@invoice_one, @invoice_two].each { |invoice| @customer_one.invoices << invoice }
    [@invoice_one, @invoice_three].each { |invoice| @merchant_one.invoices << invoice }

    @customer_two.invoices << @invoice_three
    @merchant_two.invoices << @invoice_two
  end

  def create_invoice_items
    @invoice_item_one, @invoice_item_two, @invoice_item_three, @invoice_item_four, @invoice_item_five = create_list(:invoice_item, 5)

    @invoice_item_one.update(invoice_id: @invoice_one.id, item_id: @item_one.id)
    @invoice_item_two.update(invoice_id: @invoice_three.id, item_id: @item_two.id)
    @invoice_item_three.update(invoice_id: @invoice_two.id, item_id: @item_three.id)
    @invoice_item_four.update(invoice_id: @invoice_two.id, item_id: @item_four.id)
    @invoice_item_five.update(invoice_id: @invoice_two.id, item_id: @item_five.id)
  end

  def create_transactions
    @trans_one, @trans_two, @trans_three = create_list(:transaction, 3)

    @invoice_one.transactions << @trans_one
    @invoice_two.transactions << @trans_two
    @invoice_three.transactions << @trans_three
  end
end
