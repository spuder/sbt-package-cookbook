# About

Installs sbt from packages. Provides both [custom resources](https://docs.chef.io/custom_resources.html) (formerly known as LWRPs) and recipes. **Requires chef >= 12.5.0**

This cookbook is intended for when you want to get up and running with SBT quickly (say to compile a sbt binary/package from source). All it does is add the official yum repo / apt repository and then installs sbt. 

This cookbook is **not** inteded for sbt developers who want the latest sbt version, or those who want fine grained control over your sbt environment. Those people should look at the [chef-sbt](https://supermarket.chef.io/cookbooks/chef-sbt) or [sbt-extras](https://supermarket.chef.io/cookbooks/sbt-extras) cookbooks





## Supports

- ubuntu
- centos

## Depends

- apt cookbook
- yum cookbook
- java cookbook

## Usage

You can add the `sbt-package::install` recipe to your runlist

```json
{
  "chef_type": "role",
  "run_list": [
    "recipe[apt]",
    "recipe[java]",
    "recipe[sbt-package::install]"
  ]
}
```

Or you can use the `sbt` resource in your wrapper cookbooks


```ruby
sbt 'default' do
  action :install
end
```

```ruby
# Ubuntu
sbt 'default' do
  apt_uri 'https://dl.bintray.com/sbt/debian'
  apt_keyserver 'keyserver.ubuntu.com'
  apt_key '642AC823'
  action :install
end
```

```ruby
# Centos
sbt 'default' do
  yum_baseurl 'https://bintray.com/sbt/rpm/rpm'
  action :install
end
```

```ruby
# Use with caution, install_version has limited testing
sbt 'default' do
  install_version '0.13.9'
  action :install
end
```

## Pit Falls

The sbt package has a :poop: ton of dependencies. **Installation will take a long time!** You may even think the chef process is hung. It isn't. 

## Setup

This cookbook essentially replaces the following commands to install sbt. If you just need a test environment (say with Vagrant), by all means don't use the cookbook, run these commands instead. 

```bash
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt-get update
sudo apt-get install sbt
```

```bash
curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
sudo yum install sbt
```

## Test Kitchen

If you want both an ubuntu and centos vagrant vm's spun up with test kitchen, run the following

    kitchen create
    kitchen list
    kitchen converge
    
Then log into your instance

    kitchen login default-ubuntu-1404
    kitchen login default-centos-71