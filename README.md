# circleci_hello_world
## About
This is a very barebones proof-of-concept of working with CircleCI and Docker Containers. The point is to test how a Ruby RSpec Appium test will run in a CircleCI Android Docker Container.

The tricky part is figuring out when the Appium server is running, as well as when the Android emulator is fully launched and ready to run tests against otherwise the tests will fail without properly running. This logic could be added in a test framework but the code in this repo is very barebones so as to give an idea of what is possible and is not intended to solve this problem.

## To Run
rspec 'test_spec.rb' --tag screenshot_tests

Note: The .circleci/config.yml is partially finished for being able to run automatically in CircleCI. The file contains most of the steps used to edit a CircleCI Docker container to work with Appium and Ruby RSpec. Better notes on this process are documented below (for locally setting up the Docker container).

## Setting Up A CircleCI Android Docker Image With Appium and RSpec Support (for local testing)
- docker run -it --rm --entrypoint=bash circleci/android:api-26-alpha
- mkdir ~/tmp && cd ~/tmp && alias ll='ls -l'
- curl -O 'https://nodejs.org/dist/v6.11.4/node-v6.11.4-linux-x64.tar.xz'
- tar xfJ node-v6.11.4-linux-x64.tar.xz
- export PATH=$PATH:/home/circleci/tmp/node-v6.11.4-linux-x64/bin/
- npm install -g appium@1.6.5
    - This takes about a minute (maybe longer) to install the Appium server
- npm install -g appium-doctor
    - This step is not needed for automation but more for configuring a Docker image to ensure it’s properly setup for Android and Appium
- export PATH=$PATH:$JAVA_HOME/bin
    - This export command is to fix what appium-doctor mentions needs to be fixed with the CircleCI Android Docker image
- docker ps
    - Use the above command to copy the docker container’s name under the “NAMES” column
- docker cp <path_to_this_repo>/circleci_hello_world/ <docker_container_name>:/home/circleci/tmp/
    - Either use this command to copy the repo from your local computer's HD to the Docker container or use git clone
- sudo apt-get install vim
- sudo chmod 777 circleci_hello_world/ && cd circleci_hello_world/
    - You only need to do this if you copied the folder from your local HD to the Docker container. I used 777 permissions because it's simpler for quick testing
- bundle install
    - Install Ruby Gem dependencies
- appium </dev/null &>/dev/null &
    - Run the Appium server in a background process
- ps o pid,command | grep node
    - You should see an appium process that looks something like below:
        - 11282 node /home/circleci/tmp/node-v6.11.4-linux-x64/bin/appium
- curl --silent http://127.0.0.1:4723/wd/hub/status
    - This should return a json response that informs you the appium server is up and running
- sdkmanager "system-images;android-22;default;armeabi-v7a" && echo "no" | avdmanager create avd -n test -k "system-images;android-22;default;armeabi-v7a"
    - To install the Android emulator
- rspec 'test_spec.rb' --tag screenshot_tests
    - This runs the Appium tests
