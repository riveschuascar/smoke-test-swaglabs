require 'fileutils'
require 'rake'

desc 'Run all test'
task :all do
  FileUtils.mkdir_p('reports')
  timestamp = Time.now.strftime('%m-%d-%Yhr%H-%M')
  sh("cucumber . --format html --out reports/all-tests.#{timestamp}.html")
end

desc 'Run smoke test'
task :smoke do
  FileUtils.mkdir_p('reports')
  timestamp = Time.now.strftime('%m-%d-%Yhr%H-%M')
  sh("cucumber --tags @smoke . --format html --out reports/smoke-test.#{timestamp}.html")
end