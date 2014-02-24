namespace :test do
  desc "Test lib source"
  Rake::TestTask.new(:lib) do |t|
    t.libs << "test"
    t.pattern = 'test/lib/**/*_test.rb'
    t.verbose = true
  end
 
  desc "Test services source"
  Rake::TestTask.new(:services) do |t|
   t.libs << "test"
   t.pattern = 'test/services/**/*_test.rb'
   t.verbose = true
  end
end
 
test_task = Rake::Task[:test]
test_task.enhance { Rake::Task["test:lib"].invoke }
test_task.enhance { Rake::Task["test:services"].invoke }
