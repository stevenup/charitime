# charitime
A charity community website based on wechat public account.

### Use bower to manage the front-end libraries
First, add bower-rails gem to the gemfile and then bundle install.

If you don't have bower locally, you may have to install node first, thus npm will be automatically installed, and then use npm to install bower.
```
npm install bower -g
```
Generally speaking, the speed is very slow with npm. You can go to node official website to download the pkg and install it manually.

When all the above are prepared, go to https://libraries.io to find the the plugins that you need, add it to the Bowerfile placed in the root directory. Then run these commands to install:
```
rake bower:install
rake bower:clean
rake bower:resolve
```