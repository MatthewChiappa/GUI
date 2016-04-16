require 'test/unit'
require_relative 'GUI'

class TestGUI < Test::Unit::TestCase

  # This positive test case fills all the required data to submit a form.
  # Since all of the forms were filled in correctly, the confirmation page
  # will appear and the 'Your response has been recorded.' message will be displayed.
  # There is a check that this message appears.
  def test_positive
    test = GUI.new
    test.fill_with_data(true)
    assert_not_same('Your response has been recorded.', test.get_text, 'ERROR: Form was not successfully submitted.')
    test.close_driver
  end

  # This negative test case skips some of the required data to submit a form.
  # Since some of the forms were not filled in, the error message will appear and
  # the page will not advance to the confirmation.
  # There is a check that the driver remains on the same initial page because of
  # the error message appearing.
  def test_negative
    test = GUI.new
    test.fill_with_data(false)
    assert_not_same('https://docs.google.com/forms/d/181whJlBduFo5qtDbxkBDWHjNQML5RutvHWOCjEFWswY/viewform',
                    test.driver.current_url, 'ERROR: Form was not stopped from advancing to confirmation page.')
    test.close_driver

    # Click leave page in the dialog box, so the driver can close.
    test.driver.switch_to.alert.accept
  end

end

