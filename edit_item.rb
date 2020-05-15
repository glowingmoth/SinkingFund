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

        item_percentage = item_balance / (item_target / 100.0)
        item[:percentage] = item_percentage.round(2)

        puts "Please enter item importance [1 = low] [10 = high]"
        item_importance = gets.chomp.to_i
        item[:importance] = item_importance

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

    def fund_balance(fund_balance)
        while true
            puts "What would you like to do?"
            puts "v = [view balance] [d = deposit] [w = withdraw] [q = main menu]"
            user_balance_menu_choice = gets.chomp
            if user_balance_menu_choice == "v"
                system("clear")
                puts "Total balance in the sinking fund"
                puts "$#{fund_balance}"
                sleep(3)
                system("clear")
            elsif user_balance_menu_choice == "d"
                system("clear")
                puts "How much would you like to deposit?"
                user_deposit = gets.chomp.to_i
                fund_balance += user_deposit
                system("clear")
            elsif user_balance_menu_choice == "w"
                system("clear")
                puts "How much would you like to withdraw?"
                user_withdrawl = gets.chomp.to_i
                fund_balance -= user_withdrawl
                system("clear")
            elsif user_balance_menu_choice == "q"
                break
            else
                fund_balance
            end
        end
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