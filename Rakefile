#
#  Rakefile
#
#  Copyright (c) 2015 Netguru Sp. z o.o. All rights reserved.
#

### TASKS

desc "Run the unit tests"
task "test-unit" do
  xcode_run "clean test", ENV["XCODE_SCHEME"]
end

### BUILD AND RUN

def scheme_config scheme 
  {
    "workspace" => ENV["XCODE_WORKSPACE"],
    "scheme" => scheme,
    "destination" => "'platform=iOS Simulator,name=iPhone 5s,OS=8.1'",
    "sdk" => "iphonesimulator"
  }
end

def xcodebuild_flags hash
  hash.map do |key, value|
    "-#{key} #{value}"
  end.join " "
end

def xcode_run (action, scheme)
  flags = xcodebuild_flags(scheme_config(scheme))
  sh "xcodebuild #{flags} #{action} | xcpretty -c ; exit ${PIPESTATUS[0]}" rescue nil
  report_failure "Scheme '#{scheme}' failed to '#{action}'.", $?.exitstatus unless $?.success?
end

### REPORTING

def report_success(message)
  report_common message, 2
end

def report_info(message)
  report_common message, 3
end

def report_error(message)
  report_common message, 1
end

def report_failure(message, status = 1)
  report_error message
  exit status
end

def report_common(message, color)
  color_formatter = `tput setaf #{color}`
  reset_formatter = `tput sgr 0`
  puts "#{color_formatter}#{message}#{reset_formatter}\n"
end
