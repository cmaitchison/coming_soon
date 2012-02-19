task :run_all_specs => [:spec,:run_jasmine_specs] do
   
end

task :run_jasmine_specs do
  require 'guard/jasmine/cli'
  Guard::Jasmine::CLI.start
end