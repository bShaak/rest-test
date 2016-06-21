require 'json'

class Transaction
  attr_accessor :company
  attr_reader :date, :amount, :category

  def initialize(hash)
    @date = hash['Date']
    @category = hash['Ledger'].strip
    @amount = hash['Amount'].to_f #cast to float
    @company = hash['Company']
  end

  def modify_company_name()
    @company = yield (@company)#gsub(/(#\w+|xx*.*)/, '').strip
  end
end

#Inherit from array class
class TransactionArray < Array
  def total_balance
    total = 0.0
    self.each{|transaction| total += transaction.amount}
    total
  end
end
