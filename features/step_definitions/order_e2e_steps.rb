Then('I add {string} to the cart') do |product_name|
  expect(@product_page.correct_product_displayed?(product_name)).to be true
  @product_page.add_to_cart
  expect(@product_page.remove_visible?).to be true
end

Then('I go to the overview page') do
  @checkout_page.continue_to_overview
end

Then('The overview information should be') do |table|
  data = table.hashes.first
  expect(@checkout_page.overview_information_displayed?(data)).to be true
end