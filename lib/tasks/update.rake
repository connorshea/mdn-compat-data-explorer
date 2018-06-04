namespace :update do
  desc "Walks the user through updating the MDN BCD Package."
  task :update_mdn_package do
    latest_version = `yarn info mdn-browser-compat-data version --silent`
    latest_version = latest_version.strip
    
    latest_string = "The latest version of mdn-browser-compat-data is #{latest_version}."
    # Prints the above string as bolded text.
    puts "\e[1m#{latest_string}\e[22m"

    current_version = `yarn list --pattern mdn-browser-compat-data --depth=0`
    current_version = current_version.split("@")[1]
    current_version = current_version.split("\n")[0]
    
    current_string = "The currently-used version of mdn-browser-compat-data is #{current_version}."
    # Prints the above string as bolded text.
    puts "\e[1m#{current_string}\e[22m"

    puts ""
    puts "Open the package.json file and update the mdn-browser-compat-data"\
      " version to #{latest_version}."
    puts "Do you want to open package.json in VSCode? (y/n)"

    case STDIN.gets.slice(0)
      when "y"
        puts "Opening in VSCode"
        puts "code package.json"
        system('code package.json')
      when "n"
        puts "Okay, continuing..."
    end

    puts ""
    puts "Once you've updated the version of mdn-browser-compat-data to"\
      " #{latest_version} in package.json, press Enter to continue."
    STDIN.gets
    puts "Continuing..."

    puts ""
    puts "Installing packages via 'yarn install'."
    puts "yarn install"
    system('yarn install') or exit
    
    puts ""
    puts "Open 'config/application.rb' and update config.mdn_bcd_version to"\
      " #{latest_version}."
    puts "Do you want to open 'config/application.rb' in VSCode? (y/n)"

    case STDIN.gets.slice(0)
      when "y"
        puts "Opening in VSCode"
        puts "code config/application.rb"
        system('code config/application.rb')
      when "n"
        puts "Okay, continuing..."
    end

    puts ""
    puts "Once you've updated config.mdn_bcd_version in"\
      "'config/application.rb' to #{latest_version}, press Enter to continue."
    STDIN.gets
    puts "Continuing..."

    puts ""
    puts "Regenerating 'public/data.json' with 'node lib/build.js'."
    puts "node lib/build.js"
    system('node lib/build.js') or exit
    puts "Continuing..."

    puts ""
    puts "Testing to make sure the MDN BCD versions match."
    puts "'bundle exec rake check:check_mdn_bcd_version'"
    system('bundle exec rake check:check_mdn_bcd_version') or exit
    puts "Continuing..."

    puts ""
    puts "Open 'CHANGELOG.md', add the PR link and also add the following line:"
    puts "- Upgrade the dataset to `#{latest_version}`. ([#000])"
    puts "Do you want to open 'CHANGELOG.md' in VSCode? (y/n)"

    case STDIN.gets.slice(0)
      when "y"
        puts "Opening in VSCode"
        puts "code CHANGELOG.md"
        system('code CHANGELOG.md')
      when "n"
        puts "Okay, continuing..."
    end

    puts ""
    puts "Once you've added an entry to 'CHANGELOG.md', press Enter to continue."
    STDIN.gets
    puts "Continuing..."

    puts ""
    puts "Rake task completed!"
  end
end
