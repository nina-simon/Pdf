require 'capybara/rails'

Capybara.default_driver = :selenium
Capybara.default_selector = :css
Capybara.default_wait_time = 3 #How long to wait for AJAX to appear
#Uncomment lines below to attach to running (local) debug server
#Capybara.run_server = false
#Capybara.app_host = "http://billingboss.simplytest.com:3000"


Capybara::Server.class_eval do
  
  # By default Capybara finds an open port for its server.
  # For some reason application would redirected to default app url - http://billingboss.simplytest.com:3000
  # Instead of fixing this I made the server run on 3000 port by default.
  # FIXME: Remove this hack
  
  def host
    URI::parse(::AppConfig.host).host
  end

  def find_available_port
    @port = URI::parse(::AppConfig.host).port
  end
end

class CapybaraTest < ActionController::IntegrationTest
  include TestDebugTools
  include Capybara
  
  self.use_transactional_fixtures = false
  
  fixtures :all
  
  WAIT_POLL_DELAY = 0.3 # seconds; perhaps should be env var or fugu var.
  WAIT_POLL_DELAY_TIMEOUT = 5
  
  
  # This could well be reinventing the wheel.
  def wait_for(&block)
    result = nil
    wait_time = 0
    
    while !result
      raise "wait_for timed out after #{wait_time} seconds" if wait_time > WAIT_POLL_DELAY_TIMEOUT
      
      sleep WAIT_POLL_DELAY
      wait_time += WAIT_POLL_DELAY
      
      result = yield
    end
    
    result
  end

end

Capybara::Node.class_eval do

  def selected_label
    find("option[selected]").text
  end

  def assert_field_values(expected)
    expected.zip( fields_values )
    expected.each do |expected_value|
      got_value = fields_values.shift

      next if expected_value.nil?
    end

  end

  def fields_values
    all("input[type=text], select").select(&:visible?).map do |field|

      if field[:type] == "select"
        field.selected_label
      else
        field.value
      end

    end
  end

  def fill_fields_with(values)
    all("input[type=text], select").select(&:visible?).each do |field|
      value = values.shift
      field.set(value) unless value.nil?
    end

  end

end

