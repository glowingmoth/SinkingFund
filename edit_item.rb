module Edit

    def create_item(list)
        item = Hash.new
        puts "Please enter item [name]"
        item_name = gets.chomp
        item[:name] = item_name
        system('cls')

        puts "Please enter item [description]"
        item_description = gets.chomp
        item[:description] = item_description
        system('cls')

        puts "Please enter item [target]"
        item_target = gets.chomp.to_i
        item[:target] = item_target
        system('cls')
        item_balance = 0
        item[:balance] = item_balance

        puts "Please enter item importance [1 = low] [10 = high]"
        item_importance = gets.chomp.to_i

        item_percentage = item_balance / (item_target / 100.0)
        item[:percentage] = item_percentage.round(2)

        list.push(item)
        # write_json(list)

        system('cls')
        return list
    end

    def print_list(list)
        list.each do |item|
            puts "name: #{item[:name]}"
            puts "description: #{item[:description]}"
            puts "target: $#{item[:target]}"
            puts "balance: $#{item[:balance]}"
            puts "percentage: #{item[:percentage]}%"
            puts "-------------------------"
        end
    end

    def money_distribution
        # This will distrubte the money to each item according to the item importance number
        item_balance = item_importance / ()
    end

    def fund_balance
        puts "what would you like to do [d = deposit] [w = withdraw]"
        user_gets.chomp
    end


    # def write_json(list)
    #     JSON.open("save.json", "wb") do |json|
    #         json << list
    #     end
    # end

    # def read_json
    #     list = JSON.parse("save.json")
    #     p list
    #     return list
    # end
end