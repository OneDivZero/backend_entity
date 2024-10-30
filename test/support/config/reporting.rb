#-----------------------------------------------------------------------------------------------------------------------
# Test-Reporting-Config
#-----------------------------------------------------------------------------------------------------------------------

test_reporters = [Minitest::Reporters::DefaultReporter.new(colors: true)] # Gitlab-CI

if RUBY_PLATFORM.match?(/darwin/) # OSX-Only
  require 'minitest/autorun'
  require 'minitest/macos_notification'

  test_reporters.push(Minitest::Reporters::SpecReporter.new)
  test_reporters.push(Minitest::Reporters::MacosNotificationReporter.new(title: 'BackendEntity'))
end

if ENV.fetch('USE_MINITEST_REPORTERS').eql?('true')
  Minitest::Reporters.use!(test_reporters, ENV, Minitest.backtrace_filter)
end
