# enable free gift if cart has more than 1 item or having more than 1 quantity in single line item
if Input.cart.line_items.length > 1
  fg_enable = true
elsif Input.cart.line_items.length == 1
  fg_enable = (Input.cart.line_items[0].quantity > 1) ? true : false
else
  fg_enable = false  
end

if fg_enable
  # sort line items by product variant price to apply free gift benefit on maximum priced item
  for line_item in Input.cart.line_items.sort_by{ |line_item| line_item.variant.price }.reverse
    # check if product has Free Gift tag
    if line_item.variant.product.tags.include? 'Free Gift'
      price_chg_msg = 'Updated 1 item as free gift'
      if line_item.line_price > line_item.variant.price
        # if line price is higher than variant price, then apply variant price as discount
        line_item.change_line_price(line_item.line_price - line_item.variant.price, message: price_chg_msg)  
      else
        # if line price is lower than varaint price due to any other coupon/discount factors, then set line price as 0
        line_item.change_line_price(line_item.line_price * 0, message: price_chg_msg)      
      end
      # set free_gift property
      line_item.change_properties({'free_gift' => 'yes'}, message: 'Updated item property free_gift')
      # stop loop as maximum free gift benefit is capped to only 1 item
      break
    end
  end
end

Output.cart = Input.cart
