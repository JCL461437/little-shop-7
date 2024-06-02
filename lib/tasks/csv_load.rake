require 'csv'

def generate_data_from_csv(model, file_path)
  # model.destroy_all
  CSV.foreach(file_path, headers: true) do |row|
    model.create(row.to_h)
  end
  ActiveRecord::Base.connection.reset_pk_sequence!(model.table_name)
end

namespace :csv_load do

  desc "Load data from Customers CSV"
  task customers: :environment do
    generate_data_from_csv(Customer, "./db/data/customers.csv")
  end

  desc "Load data from data from InvoiceItems CSV"
  task invoice_items: :environment do
    generate_data_from_csv(InvoiceItem, "./db/data/invoice_items.csv")
  end

  desc "Load data from Invoices CSV"
  task invoices: :environment do
  	generate_data_from_csv(Invoice, "./db/data/invoices.csv")
  end

  desc "Load data from Items Csv"
  task items: :environment do
    generate_data_from_csv(Item, "./db/data/items.csv")
  end

  desc "Load data from Merchants CSV"
  task merchants: :environment do
	  generate_data_from_csv(Merchant, "./db/data/merchants.csv")
  end

  desc "Load data from Transactions CSV"
  task transactions: :environment do
    generate_data_from_csv(Transaction, "./db/data/transactions.csv")
  end

  desc "Load Test Data from Fixture CSV"
  task test: :environment do
    generate_data_from_csv(Customer, "./db/data/customers_fixture.csv")
  end
    
  desc "Load Test Data from Fixture CSV"
  task iitest: :environment do
    generate_data_from_csv(InvoiceItem, "./db/data/invoice_items_fixture.csv")
  end

  desc "Load Test Data from Fixture CSV"
  task ittest: :environment do
    generate_data_from_csv(Item, "./db/data/items_fixture.csv")
  end

  desc "Load Test Data from Fixture CSV"
  task intest: :environment do
    generate_data_from_csv(Invoice, "./db/data/invoice_fixture.csv")
  end

  desc "Load Test Data from Fixture CSV"
  task trtest: :environment do
    generate_data_from_csv(Transaction, "./db/data/transaction_fixture.csv")
  end

  desc "Load All data from all CSVs"
  task all: :environment do
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:transactions"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
    puts "All data loaded"
  end

  desc "Load All data from all CSVs Fixtures"
  task all_fixtures: :environment do
    Rake::Task["csv_load:test"].invoke
    Rake::Task["csv_load:intest"].invoke
    Rake::Task["csv_load:trtest"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:ittest"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
    puts "All data loaded"
  end
end
