Given("that I visit the index page") do
  visit root_path
end

When("I fill {string} with {string}") do |name, field|
  fill_in field, with: content
end

When("I click {string}") do |label|
  click_on label
end

Then("I should see {string}") do |content|
  expect(page).to have_content content
end