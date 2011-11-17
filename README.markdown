# Rails Deployment Alternatives

This repository contains configuration files for installing couple of alternatives for [_Ruby On Rails_ deployment](http://rubyonrails.org/deploy).

It's purpose is mainly didatic, since I use it at workshops teaching Rails deployment,
hosting, infrastructure, provisioning and automation.

It can be quite well used to test and demonstrate automated provisioning of a clean machine
with infrastructure for running Ruby web applications.

There are three recipes for the [Sprinkle](http://github.com/crafterm/sprinkle) server provisioning tool,
showing the dominant setups for deploying Rack-based applications as of today:

### 1. Apache as a Reverse Proxy for Mongrel ###

This is historically one of the first “real” setups for deploying _Rails_ (ignoring FastCGI setups).

This setup is installed with the following command:

    $ bundle exec sprinkle --script=1-rails-stack-apache-mongrel.rb

and the web server configuration for this setup is in the [`configurations/mongrel.conf`](http://github.com/karmi/rails-deployment-setups-sprinkle/blob/master/configurations/mongrel.conf) file.

In 2006, Zed Shaw wrote [_Mongrel_](http://rubyforge.org/projects/mongrel), a Ruby webserver,
which could be easily proxied to a full-fledged webserver, such as [_Apache_](http://en.wikipedia.org/wiki/Apache_HTTP_Server).

This way, multiple _Mongrel_ instances can be launched, running on different ports, and the front-end web server
load balances between them, serving as a _reverse proxy_. It also serves static assets (stylesheets, images, etc).
This setup is still widely used with different, modern Ruby application servers such as _Unicorn_ or _Thin_.

You launch the application by running this command in the application folder:

      $ bundle exec rails server mongrel --environment production

In real life, there would be more than one application server instance running.


### 2. Nginx as a Reverse Proxy for Thin ###

A variation on this old school setup is to use the [_Nginx_](http://en.wikipedia.org/wiki/Nginx) web server as a reverse proxy /
load balancer for a cluster of [_Thin_](http://code.macournoyer.com/thin/) servers.

This setup is installed with the following command:

    $ bundle exec sprinkle --script=2-rails-stack-nginx-thin.rb

and the web server configuration for this setup is in the [`configurations/thin.conf`](http://github.com/karmi/rails-deployment-setups-sprinkle/blob/master/configurations/thin.conf) file.

In this setup, Thin is connected to Nginx via [UNIX domain sockets](http://en.wikipedia.org/wiki/Unix_domain_socket)
(see [article](http://macournoyer.wordpress.com/2008/01/26/get-intimate-with-your-load-balancer-tonight/)),
offering more power then connecting via TCP.

You launch the application by running this command in the application folder:

      $ bundle exec thin --socket /tmp/thin.sock --server 3 --environment production --tag demoapp --rackup config.ru start

A variation on this setup would be to use eg. the [_Unicorn_](http://unicorn.bogomips.org/) webserver instead of _Thin_.

Notice the `nginx_configuration` package contains a number of tricks how to speed up serving static assets with _Nginx_.


### 3. Phusion Passenger (mod_rails) ###

The latest, and most convenient alternative is the [_Phusion Passenger_](http://en.wikipedia.org/wiki/Phusion_Passenger) module
for _Apache_ or _Nginx_ web servers. In fact, it is currently the recommended setup for deploying _Rails_ applications.

This setup is installed with the following command:

    $ bundle exec sprinkle --script=3-rails-stack-passenger.rb

and the web server configuration for this setup is in the [`configurations/passenger.conf`](http://github.com/karmi/rails-deployment-setups-sprinkle/blob/master/configurations/passenger.conf) file.

_Phusion Passenger_ is distributed and [installed](http://www.modrails.com/install.html) as a [_Rubygem_](http://rubygems.org/).
The gem package includes a installer script which checks dependencies and builds/installs the module into the web server.
The script also displays information how to configure your web server and application for deployment.

The application is started “automagically”, and restarted by running this command in the application folder:

      $ touch tmp/restart.txt


## Installation and Usage ##

This repository contains definitions for installing and configuring various software via the
[_Sprinkle_](http://github.com/crafterm/sprinkle) and [_Capistrano_](http://github.com/capistrano/capistrano) tools.

See _packages_ and _configurations_ directories for details.

You run the commands locally, and they are being run on the remote machine via _Capistrano_.

First, you'll need a [_Ubuntu_](http://www.ubuntu.com/server) server reachable by SSH.

The repository contains a configuration file for the [_Vagrant_](http://vagrantup.com/) utility,
which allows you to create virtual servers on your own machine via [_VirtualBox_](http://www.virtualbox.org/wiki/Downloads).
Follow the installation instructions on the _Vagrant_ website and then run these commands to launch a new server:

    $ vagrant box add ubuntu http://files.vagrantup.com/lucid64.box
    $ vagrant up

You may of course use any other virtualization technology or use a “live” virtual server in the network. The `Rakefile` included
with the repository allows you to automatically create a new Ubuntu server
in the [Amazon Elastic Compute Cloud](http://aws.amazon.com/console/).

To install one of the provided stacks to the server, you need to have the
[_Bundler_](http://gembundler.com/) gem installed locally:

    $ gem install bundler

After downloading or cloning the repository, install the dependencies:

    $ bundle install

Copy the `deploy.example.rb` file and customize it with the connection details to your server (SSH user, server IP, etc):

    $ cp deploy.example.rb deploy.rb

Now, you can setup a server by passing a recipe to the `sprinkle` tool:

    $ bundle exec sprinkle --script=3-rails-stack-passenger.rb

The installation of an Apache/Passenger stack takes about 13 minutes on a Ubuntu 10.04 Server running
inside VMWare (1 core, 256MB RAM, 2GB HDD) on a 2011 Mac Book Air.

You can also preview packages, their dependencies and verifications by running this command:

    $ bundle exec sprinkle --test --cloud --verbose --script=3-rails-stack-passenger.rb


## Information

For more information, please see the _Sprinkle_ [readme](http://github.com/crafterm/sprinkle/tree/master/README.markdown).

The recipes and configurations were adapted from these sources:

* <http://github.com/crafterm/sprinkle/tree/master/examples/>
* <http://github.com/benschwarz/passenger-stack>
* <http://github.com/tristandunn/sprinkle-linode>

---

[Karel Minarik](http://karmi.cz)
