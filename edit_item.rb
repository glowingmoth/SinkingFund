require "json"

module Edit
    def read_fund_hash
        if (File.exist?("save.json"))
            fund_hash = JSON.parse(File.read("save.json"), :symbolize_names => true)
        else
            fund_hash = {fund_balance: 0, list: []}
        end
        return fund_hash
    end

    def write_fund_hash(fund_hash)
        File.write("save.json", JSON.generate(fund_hash))
    end

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
        ###########################
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
        # "100" -> 100 -> "100"
        # "sidjfidsjfi" -> 0 -> "0"
        #############################
        item[:target] = item_target
        system('cls')
        item_balance = 0
        item[:balance] = item_balance

        item_percentage = item_balance / (item_target / 100.0)
        item[:percentage] = item_percentage.round(2)

        puts "Please enter item importance [1 = low] [10 = high]"
        item_importance = gets.chomp.to_i
        item[:importance] = item_importance

        item[:balance] = 0;

        fund_hash[:list].push(item)

        # This is the formula to get the items individual balance
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

    def money_distribution(fund_hash)
        # This will distrubte the money to each item according to the item importance number
        fund_hash[:list].each do |item|
            item[:balance] = (fund_hash[:fund_balance] * item[:formula]).to_i
            item[:percentage] = (item[:balance] / (item[:target] / 100.0)).round(2)
            # item[:balance] = 10 + 500 * 0.5;
            #                = 10 + 250;
            # item[:balance] = 10 + 500 * 0.5;
            #                = 10 + 250;
        end
        # money = 500
        # item 1 {balance: 260}
        # item 2 {balance: 260}
    end

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
                return fund_hash[:fund_balance]
            else
                system("clear")
                puts "Invalid selection!"
                sleep(2)
                system("clear")
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

############################## Below this line are methods not directly related to editing items #####################
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