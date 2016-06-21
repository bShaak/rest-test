##Rest Test implemented in Ruby with Sinatra

###Build Instructions

###Installing Ruby and RubyGems

If you don't already have Ruby and RubyGems installed.
Install RVM the ruby version manager and install ruby version 2.2.3.
```shell
    curl -L https://get.rvm.io | bash -s stable --ruby=2.2.3
```

At the end of installation log out and log back in. Then it will ask you to run the command
```shell
    source ~/.rvm/scripts/rvm
```

###Installing gems
The test app depends on the Sinatra and Rest-Client

```shell
    gem install sinatra --no-ri --no-rdoc
```

```shell
    gem install rest-client
```

###Running the app
Navigate to the base directory and run
```shell
    ruby app.rb
```

Now open http://localhost:4567
in your web browser. You should see a list of transactions and
a total balance.

I also implemented two of the bonus features.
Please notice that the vendor names have been scrubbed of garbage text and
try navigating to the Category page.
