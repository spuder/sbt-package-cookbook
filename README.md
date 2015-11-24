# sbt-package

A library cookbook that installs the sbt yum repo / apt repository and the latest version of sbt

## Supports

- ubuntu
- centos

## Usage

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

## Limitations

The sbt package has a :poop: tone of dependencies. Installation will take a long time.
Currently does not support installing a specific version

## Setup

This cookbook essentially replaces the following commands to install sbt

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
