# Description
## Chef Solo proxy environment variable
Adds a proxy environment variable to Chef Solo. I ran into a problem where my Vagrant box could not provision behind the company proxy, after reading this thread: https://github.com/mitchellh/vagrant/issues/640 I decided to write a cookbook that I could drop into my run list.

# Attributes
 * ###[chef_solo_proxy][http_proxy]
    Sets an environment variable for the http proxy
    Default value: nil

 * ###[chef_solo_proxy][https_proxy]
    Sets an environment variable for the https secure proxy
    Default value: nil

 * ###[chef_solo_proxy][no_proxy]
    List of hosts that should not be called through the proxy

# Usage
In my vagrant file I use the following:

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
    config.vm.box = 'precise64'
    #Provision
    config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = 'cookbooks'
        chef.json = {
          :chef_solo_proxy => {
              :https_proxy => 'https://my.httpsproxy.url:80',
              :http_proxy => 'http://my.httpproxy.url:80'
              :no_proxy => ['127.0.0.1', '192.168.1.1']
            }
        }
        chef.add_recipe 'chef_solo_proxy'
        chef.add_recipe 'apt'
    end
end
```

# run tests:
    chef exec rspec --color spec/unit/recipes/*_spec.rb
    kitchen test

# run style checks:
    rubocop
    foodcritic recipes/default.rb

### Note
Make sure that you add the "chef_solo_proxy" before "apt" or any other cookbook that requires the proxy in your run list.

