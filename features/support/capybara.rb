# :culerity or :selenium
Capybara.javascript_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Driver::Selenium.new(app, :browser => :chrome)
end