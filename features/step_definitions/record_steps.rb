Given /^I am on the new record page$/ do
  visit new_record_path
end
Given /^I am on the records page$/ do
  visit records_path
end
Given /^I am viewing any record$/ do
  @record = Factory.create(:record)
  visit record_path @record
end

When /^I add a new record$/ do
  fill_in 'Claim Number', with: '12345'

  fill_in 'Last',   with: 'Stacey'
  fill_in 'Middle', with: 'Brice'
  fill_in 'First',  with: 'Matthew'
  fill_in 'Title',  with: 'Mr.'

  fill_in 'Age at initiation', with: '21'

  click_button 'Create Record'
end

Then /^I should see the page for my newly created record$/ do
  current_path = URI.parse(current_url).path
  current_path.should eq(record_path(Record.last))
end

Then /^the notice 'The record has been created\.'$/ do
  page.should have_css('#notice', text: 'Record was successfully created.')
end

Then /^I should see all of the record's attributes$/ do
  pending
  @record.attributes.each do |k,v|
    page.should have_content(v)
  end
end

Then /^I should see a paginated list of all the records$/ do
  pending
end

Then /^I should see facets for courts$/ do
  pending
end

Then /^I should be able to request that record$/ do
  pending
end
