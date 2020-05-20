# Sinking Fund
<br>

## Purpose<br>
1. To practice programming, version control, project managment and problem solving.
2. I wanted a personal sinking fund to track money allocation for each item in the fund. While there are plenty of these apps already available, when considering the the reasons listed above it made sense.
3. To have the foundations in place for working with web apps.

## Features<br>
- Create and delete items
- Each item will have a name, description, target, balance, percentage and importance
- When an item reaches 100% of its target no more money should be allocated to it
- User will be able to view all the items in the fund
- When an item is deleted the funds will automatically be deducted from the sinking fund (like in the case of a target being reached) in the other scenario if an item is removed but the money wasn't used the money will be redistributed based on the items still left in the fund
- The app must automatically save data and therefore read and write to a file.

## Help/Documentation

## Known issues
After withdrawing from the sinking fund items arent updated in the percentage. If items have previously reached 100% and you withdraw funds, even if the item is leass than the target it shows 100%.

