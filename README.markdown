# Rails Deployment Alternatives

This repository contains configuration files for installing couple of alternatives for [_Ruby On Rails_ deployment](http://rubyonrails.org/deploy).

It's purpose is mainly didatic, since I use it at workshops teaching Rails deployment, hosting, infrastructure.

But it can be equally well used to provision a clean machine with infrastructure for a Rails application deployment.

There are three recipes for the [Sprinkle](http://github.com/crafterm/sprinkle) server provisioning tool,
showing the dominant setups for deploying Rack-based applications as of today:

### 1. Apache as a Reverse Proxy for Mongrel ###

This is historically one of the first “real” setups for deploying _Rails_ (ignoring FastCGI setups).

This setup is installed with the following command:

    $ bundle exec sprinkle --script=1-rails-stack-apache-mongrel.rb

and the web server configuration for this setup is in the `configurations/mongrel.conf` file.

In 2006, Zed Shaw wrote [_Mongrel_](http://rubyforge.org/projects/mongrel), a Ruby webserver,
which could be easily proxied to a full-fledged webserver, such as [_Apache_](http://en.wikipedia.org/wiki/Apache_HTTP_Server).

This way, multiple _Mongrel_ instances can be launched, and the front-end web server load balances between them,
serving as a _reverse proxy_. It also serves static assets (stylesheets, images, etc). This setup is still widely used
with different application servers such as _Unicorn_ or _Thin_.

You launch the application by running command:

      $ bundle exec rails server mongrel --environment production

In real life, there would be more than one application server instance running. However, the _mongrel_cluster_ Rubygem
does not work with current versions of the _Ruby On Rails_ framework, so the purpose of this recipe is purely didactic.


### 2. Nginx as a Reverse Proxy for Thin ###

A variation on this old school setup is to use the [_Nginx_](http://en.wikipedia.org/wiki/Nginx) web server as a reverse proxy /
load balancer for a cluster of [_Thin_](http://code.macournoyer.com/thin/) servers.

This setup is installed with the following command:

    $ bundle exec sprinkle --script=2-rails-stack-nginx-thin.rb

and the web server configuration for this setup is in the `configurations/thin.conf` file.

In our setup, Thin is connected to Nginx via [UNIX domain sockets](http://en.wikipedia.org/wiki/Unix_domain_socket)
(see [article](http://macournoyer.wordpress.com/2008/01/26/get-intimate-with-your-load-balancer-tonight/)),
offering more power then connecting via TCP.

You launch the application by running command:

      $ bundle exec thin --socket /tmp/thin.sock --server 3 --environment production --tag demoapp --rackup config.ru start

A variation on this setup would be to use the [_Unicorn_](http://unicorn.bogomips.org/) webserver instead of _Thin_.


### 3. Phusion Passenger (mod_rails) ###

The latest, and most convenient alternative is the [_Phusion Passenger_](http://en.wikipedia.org/wiki/Phusion_Passenger) module
for _Apache_ or _Nginx_ web servers. In fact, it is currently the recommended setup.

This setup is installed with the following command:

    $ bundle exec sprinkle --script=3-rails-stack-passenger.rb

and the web server configuration for this setup is in the `configurations/passenger.conf` file.

_Phusion Passenger_ is distributed and [installed](http://www.modrails.com/install.html) as a [_Rubygem_](http://rubygems.org/).
The package includes a installer script to check dependencies and install the module into the web server.
It displays information how to setup your web server and application for deployment.

You launch the application by running command:

      $ touch tmp/restart.txt


## Installation and Usage ##

This repository contains number of recipes and configurations for installing software packages
via [_Sprinkle_](http://github.com/crafterm/sprinkle) and [_Capistrano_](http://github.com/capistrano/capistrano) tools.

See _packages_ and _configurations_ directories for details.

You run the commands locally, and they are being run on the remote machine via _Capistrano_.

First, you'll need a [Ubuntu](http://www.ubuntu.com/server) based [VPS](http://en.wikipedia.org/wiki/Virtual_private_server) reachable by SSH.

To install one of the provided stacks to the server, you need to have the
[_Bundler_](http://gembundler.com/) gem installed locally:

    $ gem install bundler

After downloading or cloning the repository, install the dependencies:

    $ bundle install

Copy the `deploy.example.rb` file and provide the connection details to your server (SSH user, server IP):

    $ cp deploy.example.rb deploy.rb

Then, you can setup a server by passing a recipe to the `sprinkle` tool:

    $ bundle exec sprinkle --script=3-rails-stack-passenger.rb

The installation of an Apache/Passenger stack takes about 15 minutes on a Ubuntu 10.04 Server running
inside VMWare (1 core, 256MB RAM, 2GB HDD) on a Mac Book Air.

You can also preview packages, their dependencies and verifications:

    $ bundle exec sprinkle --test --cloud --verbose --script=3-rails-stack-passenger.rb


## Information

For more information, please see the _Sprinkle_ [readme](http://github.com/crafterm/sprinkle/tree/master/README.markdown).

The recipes and configurations were adapted from these sources:

* <http://github.com/crafterm/sprinkle/tree/master/examples/>
* <http://github.com/benschwarz/passenger-stack>
* <http://github.com/tristandunn/sprinkle-linode>

---

[Karel Minarik](http://karmi.cz)
