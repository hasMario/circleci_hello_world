RSpec.configure do |config|
  logger = nil

  config.before(:suite) do
    sw_before_suite = Stopwatch.new

    # Setup logger for this file
    logger = Logging.new("DEBUG", (File.basename __FILE__)).return_logger
    logger.debug("logger id: #{logger.__id__}")
    logger.debug("logger level: #{logger.instance_variable_get(:@level)}")
    logger.debug("logger progname: #{logger.instance_variable_get(:@progname)}")

    logger.debug("The 'before(:suite)' block took "\
                 "#{sw_before_suite.elapsed_time} to complete.")
  end

  config.before(:all) do
    sw_before_all = Stopwatch.new
    puts
    logger.info("Test Group Started...")

    @toml_caps = TomlRB.load_file('app/android_api_22.toml')
    @toml_caps = Appium.symbolize_keys(@toml_caps)

    logger.debug("Defined Capabilities Before Modified:")
    ap @toml_caps, options = { :indent => -4 }

    # Start the app on the device
    logger.info("About to start the appium driver...")
    Appium::Driver.new(@toml_caps).start_driver
    logger.info("The Appium driver started.")

    # Promote Appium methods
    classes_to_promote = [RSpec::Core::ExampleGroup]
    logger.debug("Promoting Appium methods to the "\
                  "#{classes_to_promote.join(' & ')} classes...")
    Appium.promote_appium_methods(classes_to_promote)
    logger.debug("Appium methods have been promoted to the "\
                  "#{classes_to_promote.join(' & ')} classes.")

    # Check if Appium is loaded and can be called upon within the code
    if driver_attributes[:automation_name].nil?
      logger.debug("Automation style is UIAutomator.")
    end

    logger.debug("The 'before(:all)' block took "\
                 "#{sw_before_all.elapsed_time} to complete.")
    puts if logger.debug?
  end

  config.before(:each) do
    puts
    puts "this runs before each test."
    puts
  end

  config.after(:each) do |example|
    puts
    puts "this runs after each test."
    puts
  end

  config.after(:all) do
    puts
    puts
    puts
    logger.info("Test group finished.")
    sw_after_all = Stopwatch.new

    logger.debug("The 'after(:all)' block took "\
                 "#{sw_after_all.elapsed_time} to complete.")
  end

  config.after(:suite) do
    sw_after_suite = Stopwatch.new

    logger.info("Cleanup complete.") if !logger.nil?

    logger.debug("The 'after(:suite)' block took "\
                 "#{sw_after_suite.elapsed_time} to complete.")  if !logger.nil?
  end
end
