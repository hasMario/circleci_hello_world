load 'android_setup.rb'

describe "TestCircleCIAndroidEmulator", :screenshot_tests do

  screenshot_path = "tmp/"

  before(:all) do
    @logger = Logging.new("DEBUG", (File.basename __FILE__)).return_logger
    @logger.debug("Logger has been setup for the TestCircleCIAndroidEmulator spec.")
  end

  before(:each) do
    puts "Before each test runs!"
  end

  context 'When in portrait mode', :screenshot_tests_portrait do

    it "Test1: Takes a screenshot of the Main Activity", :test1 do |example|
      sw_test = Stopwatch.new
      @logger.info("Running Test: \"#{example.full_description}\"...")
      screenshot_path_and_name = screenshot_path + "test1_ss.png"
      screenshot screenshot_path_and_name
      @logger.info("Test finished.")
      @logger.debug("The test took #{sw_test.elapsed_time} to complete.")
    end

    it "Test2: Takes a screenshot of the Main Activity", :test2 do |example|
      sw_test = Stopwatch.new
      @logger.info("Running Test: \"#{example.full_description}\"...")
      screenshot_path_and_name = screenshot_path + "test2_ss.png"
      screenshot screenshot_path_and_name
      @logger.info("Test finished.")
      @logger.debug("The test took #{sw_test.elapsed_time} to complete.")
    end

  end
end
