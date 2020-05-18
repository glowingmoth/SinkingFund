require_relative "edit_item.rb"
include Edit

fund_hash = Edit.read_fund_hash
Edit.money_distribution(fund_hash)

while true
    system("clear")
    puts "Sinking Fund"
    puts ""
    puts "[1] Create item"
    puts "[2] View items"
    puts "[3] Fund Balance"
    puts "[4] Exit"

    user_menu_choice = gets.chomp.to_i

    if user_menu_choice == 1
        system("clear")
        fund_hash = Edit.create_item(fund_hash)
        Edit.money_distribution(fund_hash)
        system("clear")
    elsif user_menu_choice == 2
        while true
            system("clear")
            if fund_hash[:list].empty?
                puts "There are currently no items in the Sinking Fund"
                sleep(3)
                break
            else
                Edit.print_list(fund_hash)
                if Edit.exit_to_main_menu
                    break
                end
            end
        end
    elsif user_menu_choice == 3
        system("clear")
        fund_hash = Edit.fund_balance_menu(fund_hash)
    elsif user_menu_choice == 4
        system("clear")
        # Confirm exit method
        puts "Are you sure you want to exit? [y = yes][n = no]"
        user_exit_choice = gets.chomp

        if user_exit_choice == "y"
            exit
        else
            # Stay in program
        end

    else

    end
end