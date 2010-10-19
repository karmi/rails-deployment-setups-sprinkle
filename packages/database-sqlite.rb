package :sqlite, :provides => :database do
  description 'SQLite3 database'
  apt 'sqlite3'

  verify do
    has_executable 'sqlite3'
  end

  optional :sqlite_ruby_driver
end

package :sqlite_ruby_driver do
  requires :rubygems
  description 'Ruby SQLite3 library.'
  apt 'libsqlite3-dev libsqlite3-ruby1.8'
  gem 'sqlite3-ruby'

  verify do
    has_gem       'sqlite3-ruby'
    ruby_can_load 'sqlite3'
  end
end
