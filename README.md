# shopify-script-freegift

shopify script to run on every cart update to provide free gift discount on eligible line item


## eligibility
- cart should have minimum 2 line items or atleast one line item with minimum 2 quantity
so that the free gift benefit doesn't apply when only 1 free gift eligible item is in cart which will unnecessarily allow user to just purchase that free gift item alone for free
- line items with tag 'Free Gift' are only eligible


## logic to provide maximum discount benefit
- cart items are sorted based on price to provide free gift discount to the line item which has the maximum price among all other eligible line items in cart


## discount capping
- free gift discount capped to apply for maximum 1 quantity of the line item


## line item property update
- 'free_gift' property will be added to the line item with value 'yes' for better order management
