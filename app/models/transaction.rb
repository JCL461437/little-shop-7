class Transaction < ApplicationRecord
  belongs_to :invoice

  enum results: { success: 0, failed: 1 }
end