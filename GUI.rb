require 'selenium-webdriver'

class GUI

  # Initialize Selenium and navigate to the page
  def initialize
    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to 'https://docs.google.com/forms/d/181whJlBduFo5qtDbxkBDWHjNQML5RutvHWOCjEFWswY/viewform'
  end

  # Return the Selenium driver
  def driver
    @driver
  end

  # Fills the form with data to run test cases
  #
  # If valid_data is set true, fill all forms for a positive case
  # Else, skip filling in one of the text boxes for the negative case
  def fill_with_data(valid_data)
    # Enter text for name field
    nameText = @driver.find_element(:class, 'ss-q-short')
    nameText.send_keys('Test Name')

    # If positive test case is being generated, check a radio button
    # Else, skip over required field and generate error message
    if valid_data
      radioYes = @driver.find_element(:class, 'ss-q-checkbox')
      radioYes.click
    end

    # Get dropdown list, get all the options from the dropdown, and
    # find the dropdown value by text
    dropdown = @driver.find_element(:id, 'entry_262759813')
    options = dropdown.find_elements(tag_name: 'option')
    options.each { |option| option.click if option.text == 'Cucumber' }

    # Enter text for comment box
    comment = @driver.find_element(:class, 'ss-q-long')
    comment.send_keys('This is a test comment.')

    # Get and click the submit button
    submit = @driver.find_element(:id, 'ss-submit')
    submit.click
  end

  # Return confirmation text
  def get_text
    @driver.find_element(:class, 'ss-resp-message').text
  end

  # Close the Selenium driver
  def close_driver
    @driver.close
  end

end
