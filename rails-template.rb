require 'rubygems'

run "rm public/index.html"
run "rm public/images/rails.png"
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"

git :init
git :add => '.'
git :commit => "-m 'Initial commit: Clean application'"

puts
say_status  "Rubygems", "Adding Rubygems into Gemfile...\n", :yellow
puts        '-'*80, ''; sleep 1

gem 'thin',    '1.3.0'

git :add => '.'
git :commit => "-m 'Added gems'"

puts
say_status  "Rubygems", "Installing Rubygems...", :yellow
puts        '-'*80, ''

run "bundle install"

puts
say_status  "Model", "Generating the Article resource...", :yellow
puts        '-'*80, ''; sleep 1

generate :scaffold, "Article title:string content:text published:boolean"
route    "root :to => 'articles#index'"
rake     "db:migrate", :env => "production"

git :add => '.'
git :commit => "-m 'Generated the Article resource'"

puts  "", "="*80
say_status  "DONE", "Application generated", :yellow
