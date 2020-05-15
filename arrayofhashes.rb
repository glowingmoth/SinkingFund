fund_balance = 1000
item_balance = 0
all_items_importance = 0

# List is an array of hashes, containing the infor for each item
list = [
    {name: "holiday", balance: item_balance, importance: 10},
    {name: "telescope", balance: item_balance, importance: 3},
    {name: "tyres", balance: item_balance, importance: 7}
]

# This will return the value needed for "all_items_importance" can be turned into a method
list.each do |item|
    all_items_importance += item[:importance]
end

# This is the formula to get the items individual balance
item_balance = item_importance / all_items_importance * 100

# Name: Holiday
# Description: Family trip
# Target: 5000
# Balance: 200
# Percantage: 10%
# Importance: 7