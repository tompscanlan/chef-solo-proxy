name 'chef_solo_proxy'
maintainer 'Tom Scanlan'
license 'MIT'
description 'Sets up a proxy environment variable for chef solo'
version '0.0.3'

attribute 'chef_solo_proxy/http_proxy',
          description: 'Set environment variable for the http proxy',
          default: nil

attribute 'chef_solo_proxy/https_proxy',
          description: 'Set environment variable for the https secure proxy',
          default: nil

attribute 'chef_solo_proxy/no_proxy',
          description: 'List of servers that shouldn\'t pass thru proxy',
          default: nil
