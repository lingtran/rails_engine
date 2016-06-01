require 'csv'
namespace :import_data do
  desc "Import customers from CSV"
  task customers: :environment do
    filename = File.join Rails.root, 'db/data/customers.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      customer = Customer.create(row.to_h)
      puts "#{customer.errors.full_messages.join(", ")}" if customer.errors.any?
      counter +=1 if customer.persisted?
    end

    puts "Successfully imported #{counter} customers"
  end

  desc "Import merchants from CSV"
  task merchants: :environment do
    filename = File.join Rails.root, 'db/data/merchants.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      merchant = Merchant.create(row.to_h)
      puts "#{merchant.errors.full_messages.join(", ")}" if merchant.errors.any?
      counter +=1 if merchant.persisted?
    end

    puts "Successfully imported #{counter} merchants"
  end

  desc "Import invoices from CSV"
  task invoices: :environment do
    filename = File.join Rails.root, 'db/data/invoices.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      invoice = Invoice.create(row.to_h)
      puts "#{invoice.errors.full_messages.join(", ")}" if invoice.errors.any?
      counter +=1 if invoice.persisted?
    end

    puts "Successfully imported #{counter} invoices"
  end

  desc "Import items from CSV"
  task items: :environment do
    filename = File.join Rails.root, 'db/data/items.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      item = Item.create(row.to_h)
      puts "#{item.errors.full_messages.join(", ")}" if item.errors.any?
      counter +=1 if item.persisted?
    end

    puts "Successfully imported #{counter} items"
  end

  desc "Import invoice_items from CSV"
  task invoice_items: :environment do
    filename = File.join Rails.root, 'db/data/invoice_items.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      invoice_item = InvoiceItem.create(row.to_h)
      puts "#{invoice_item.errors.full_messages.join(", ")}" if invoice_item.errors.any?
      counter +=1 if invoice_item.persisted?
    end

    puts "Successfully imported #{counter} invoice items"
  end

  desc "Import transactions from CSV"
  task transactions: :environment do
    filename = File.join Rails.root, 'db/data/transactions.csv'
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      transaction = Transaction.create(row.to_h)
      puts "#{transaction.id} - #{transaction.errors.full_messages.join(", ")}" if transaction.errors.any?
      counter +=1 if transaction.persisted?
    end

    puts "Successfully imported #{counter} transactions"
  end

  desc "Import all items collectively"
  task all: [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]
end
