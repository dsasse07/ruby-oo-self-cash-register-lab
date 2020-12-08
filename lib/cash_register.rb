require 'pry'
class CashRegister
    def initialize(discount=0)
        @total = 0
        @discount = discount
        @cart = []
        @transactions = []
        @items = []
    end

    attr_accessor :discount
    attr_reader :total

    def total= (total)
        @total = total
    end
    
    def add_item (item, price, quantity=1)
        @transactions << {item => {:price => price, :quantity => quantity}}
        self.update_cart
    end

    def apply_discount
        if @discount == 0
            "There is no discount to apply."
        else 
            @total -= (@discount.to_f/100)*@total
            "After the discount, the total comes to $#{@total.to_i}."
        end
    end

    def items
        @cart.each do |item_hash|
            @items << item_hash.keys
        end
        @items.flatten!
    end
    
    def void_last_transaction
        @transactions.pop
        self.update_cart
    end

    def update_cart
        @total = 0
        @cart = []
        @transactions.each do |item|
            item.each do |item_name, item_info|
                item_info[:quantity].times do 
                    @cart << {item_name => item_info[:price]}
                    @total += item_info[:price]
                end
            end
        end
    end


end