Given("I am logged in as a Standard User") do
  @login_page.visit_page
  @login_page.login_as('standard_user', 'secret_sauce')
  expect(@inventory_page).to be_displayed
end

When("I click on the {string} link") do |product_name|
  case product_name
  when 'Back to products'
    @product_page.go_back_to_products
  else
    @product_page.open_from_inventory(product_name)
  end
end

Given("I am on the {string} product page") do |product_name|
  step %(I am logged in as a Standard User)
  step %(I click on the "#{product_name}" link)
end

Then("the following product information should be displayed") do |table|
  data = table.rows_hash
  expect(@product_page).to be_displayed
  expect(@product_page.name).to eq(data['title'])
  expect(@product_page.price).to eq(data['price'])
end

Then('the button {string} is visible') do |_button_text|
  expect(@product_page).to be_add_to_cart_visible
end

Then("I am redirected to the Products page") do
  expect(@inventory_page).to be_displayed
  expect(page).to have_content('Products')
end

Then("I can see the list of products") do
  expect(@inventory_page).to be_displayed
  expect(all('.inventory_item').count).to eq(6)
end
