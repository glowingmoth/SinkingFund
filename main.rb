require_relative "edit_item.rb"
include Edit

fund_balance = 0
list = []

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
        item = Edit.create_item(list)
        system("clear")
    elsif user_menu_choice == 2
        system("clear")
        if list.empty?
            puts "There are currently no items in the Sinking Fund"
        else
            Edit.print_list(list)
        end
    elsif user_menu_choice == 3
        system("clear")
            Edit.fund_balance(fund_balance)
    elsif user_menu_choice == 4
        system("clear")
        # Confirm exit method
        puts "Are you sure you want to exit? [y = yes][n = no]"
        user_exit_choice = gets.chomp

        if user_exit_choice == "y"
            # Exit program
        else
            # Stay in progam
        end

    else

    end
end