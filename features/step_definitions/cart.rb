def login_with_clean_cart
  @login_page.visit_page
  @login_page.login_as('standard_user', 'secret_sauce')
  @inventory_page.visit_directly
end

# ─── Background ──────────────────────────────────────────────────────────────

Given('I am logged in with a clean cart') do
  login_with_clean_cart
end

# ─── Inventory ───────────────────────────────────────────────────────────────

When('I add {string} to the cart from the inventory page') do |product|
  case product
  when "Sauce Labs Backpack"
    @inventory_page.add_backpack_to_cart
  else
    raise "Producto no registrado: '#{row.fetch('product')}'"
  end
end

When('I add the following product to the cart from the inventory page') do |table|
  table.hashes.each do |row|
    case row.fetch('product')
    when 'Sauce Labs Backpack'
      @inventory_page.add_backpack_to_cart
    else
      raise "Producto no registrado: '#{row.fetch('product')}'"
    end
  end
end

When('I remove {string} from the inventory page') do |product|
  @inventory_page.remove_backpack_from_cart
end

# ─── Product detail ──────────────────────────────────────────────────────────

When('I open the detail page for {string}') do |product|
  @inventory_page.open_product(product)
end

When('I add {string} to the cart from the product detail page') do |product|
  @product_page.add_to_cart
end

When('I remove {string} from the product detail page') do |product|
  @product_page.remove_from_cart
end

# ─── Cart ────────────────────────────────────────────────────────────────────

When('I open the cart page') do
  @cart_page.open
end

When('I remove {string} from the cart page') do |product|
  @cart_page.remove_product(@cart_page.cart_product(product)[:cart_remove])
end

When('I click the continue shopping button') do
  @cart_page.continue_shopping
end

When('I click the checkout button') do
  @cart_page.go_to_checkout
end

# ─── Assertions ──────────────────────────────────────────────────────────────

Then('the cart badge should show {string}') do |quantity|
  expect(@cart_page.badge_count).to eq(quantity)
end

Then('the cart badge should not be visible') do
  expect(@cart_page).not_to be_badge_visible
end

Then('the cart item for {string} should not be visible') do |product|
  expect(@cart_page).not_to be_item_visible(product)
end

Then('I should be redirected to the checkout information page') do
  expect(@cart_page).to be_on_checkout_page
end