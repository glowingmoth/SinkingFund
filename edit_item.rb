require "json"

module Edit

    # For reading the fund details from the json file
    def read_fund_hash
        if (File.exist?("save.json"))
            fund_hash = JSON.parse(File.read("save.json"), :symbolize_names => true)
        else
            fund_hash = {fund_balance: 0, list: []}
        end
        return fund_hash
    end

    # For writing to the json file
    def write_fund_hash(fund_hash)
        File.write("save.json", JSON.generate(fund_hash))
    end

    # This will create the fund using an array of hashes and store it in a json file for reading an writing
    def create_item(fund_hash)
        item = Hash.new
        puts "Please enter item [name]"
        item_name = gets.chomp
        item[:name] = item_name
        system('cls')

        puts "Please enter item [description]"
        item_description = gets.chomp
        item[:description] = item_description
        system('cls')

        # Here the block of code will insure the user enters numbers using techniques from regular expressions (regex)
        item_target = 0
        loop do
            puts "Please enter item [target]"
            input_target = gets.chomp
            if input_target.to_i.to_s != input_target
                system("clear")
                puts "Please input numbers only!"
                sleep(2)
                system("clear")
            else
                item_target = input_target.to_i
                break
            end
        end

        item[:target] = item_target
        system('cls')
        item_balance = 0
        item[:balance] = item_balance

        item_percentage = item_balance / (item_target / 100.0)
        item[:percentage] = item_percentage

        puts "Please enter item importance [1 = low] [10 = high]"
        item_importance = gets.chomp.to_i
        item[:importance] = item_importance

        item[:balance] = 0;

        fund_hash[:list].push(item)

        # This is the method to get the items individual balance
        update_all_items_formula(fund_hash[:list])
        write_fund_hash(fund_hash)

        system('cls')
        return fund_hash
    end

    # This will return the value needed for "all_items_importance"
    def update_all_items_formula(list)
        all_items_importance = 0
        list.each do |item|
            all_items_importance += item[:importance]
        end

        list.each do |item|
            item[:formula] = item[:importance].to_f / all_items_importance
        end

        # item 1 {target: 1000 balance: 10, importance: 10, percentage: '1%', formula: 10/20 = 0.5}
        # item 2 {target: 1000 balance: 10, importance: 10, percentage: '1%', formula: 10/20 = 0.5}
        # all_items_importance = 20

    end

    # For viewing the list of items ion the fund
    def print_list(fund_hash)
        fund_hash[:list].each do |item|
            puts "Name: #{item[:name]}"
            puts "Description: #{item[:description]}"
            puts "Target: $#{item[:target]}"
            puts "Balance: $#{item[:balance]}"
            puts "Percentage: #{item[:percentage]}%"
            puts "Importance: #{item[:importance]}"
            puts "-------------------------"
        end
    end

    # Distribute the money based on importance for each item
    def money_distribution(fund_hash)
        # This will distrubte the money to each item according to the item importance number

        # total balance is fund_hash[:fund_balance]

        total_balance = 0

        fund_hash[:list].each do |item|

            temp_balance = (fund_hash[:fund_balance] * item[:formula]).to_i

            if temp_balance > item[:target]
                item[:balance] = item[:target]
            else
                item[:balance] = temp_balance
            end

            total_balance += item[:balance]

            # item[:balance] = (fund_hash[:fund_balance] * item[:formula]).to_i
            item[:percentage] = (item[:balance] / (item[:target] / 100.0)).round(2)

        end

        

        if total_balance < fund_hash[:fund_balance]
            leftover_fund_balance = fund_hash[:fund_balance] - total_balance
            sorted_items = fund_hash[:list].sort_by {|item| -item[:importance]}
            # start here with iteration of sorted_items
            sorted_items.map! do |item|
                if item[:balance] == item[:target] 
                    item
                else # if item[:balance] < item[:target] 
                    leftover_item_balance = item[:target] - item[:balance]
                    if leftover_item_balance <= leftover_fund_balance
                        item[:balance] = item[:target]
                        leftover_fund_balance -= leftover_item_balance;
                    else
                        item[:balance] += leftover_fund_balance
                        leftover_fund_balance = 0
                    end
                end
            end
        end
    end

    # The menu where you can view deposit or withdraw money from the fund
    def fund_balance_menu(fund_hash)
        while true
            puts "What would you like to do?"
            puts "v = [view balance] [d = deposit] [w = withdraw] [q = main menu]"
            user_balance_menu_choice = gets.chomp
            if user_balance_menu_choice == "v"
                system("clear")
                puts "Total balance in the sinking fund"
                puts "$#{fund_hash[:fund_balance]}"
                sleep(3)
                system("clear")
            elsif user_balance_menu_choice == "d"
                system("clear")
                puts "How much would you like to deposit?"
                user_deposit = gets.chomp.to_i
                fund_hash[:fund_balance] += user_deposit
                money_distribution(fund_hash)
                write_fund_hash(fund_hash)
                system("clear")
            elsif user_balance_menu_choice == "w"
                system("clear")
                puts "How much would you like to withdraw?"
                user_withdrawl = gets.chomp.to_i
                fund_hash[:fund_balance] -= user_withdrawl
                money_distribution(fund_hash)
                write_fund_hash(fund_hash)
                system("clear")
            elsif user_balance_menu_choice == "q"
                return fund_hash
            else
                system("clear")
                puts "Invalid selection!"
                sleep(2)
                system("clear")
            end
        end
    end

    # This will remove an item from the sinking fund and either remove the money also or redistribute based on the reason for removing
    def remove_item

    end

end

module Other

    def exit_to_main_menu
        puts ""
        puts "[q = main menu]"
        user_exit = gets.chomp
        if user_exit == "q"
            return true
        else
            return false
        end
    end

end
