require 'rubygems'
require 'selenium-webdriver'

Given ('Enabled BStack Automate') do
  @caps = Selenium::WebDriver::Remote::Capabilities.new
  @caps['browser'] = 'Chrome'
  @caps['os_version'] = '10'
  @caps['resolution'] = '1920x1080'
  @caps['os'] = 'Windows'
  @caps['browser_version'] = 'latest'
  @caps['javascriptEnabled'] = 'true'
  @caps['name'] = 'BStack-Cucumber Assignment' # test name
  @caps['build'] = 'BStack Build Number 2' # CI/CD job or build name
end

Given ('I am on Amazon website') do
  @driver = Selenium::WebDriver.for(:remote,
    :url => "https://jatindandelia_qLfxh4:gJCYx1LpA6s1CK4BzSzZ@hub-cloud.browserstack.com/wd/hub",
    :capabilities => @caps)
  @driver.navigate.to "https://www.amazon.in/"
  @wait = Selenium::WebDriver::Wait.new(:timeout => 20)
  @search_bar = @wait.until {@driver.find_element(:id => "twotabsearchtextbox")}
end

When ('I search for Mobile Phone') do
  @search_bar.click
  @search_bar.send_keys 'mobile phone'
  @search_button = @wait.until {@driver.find_element(:id => "nav-search-submit-button")}
  @search_button.click
end

Then ('Title should contain mobile phone') do
  @url = @driver.title
  @tested = false
  puts @url
  if (@url.include? "mobile phone")
    @driver.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Yaay! My test has passed!"}}')
    @tested = true
  else
    @driver.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Oops! My test has failed!"}}') 
  end
  @driver.quit
  expect(@tested).to eq(true)
end
