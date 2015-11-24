resource_name :sbt
# Apt settings
property :apt_uri, String, default: 'https://dl.bintray.com/sbt/debian'
property :apt_key, String, default: '642AC823'
property :apt_keyserver, String, default: 'keyserver.ubuntu.com'
# Yum settings
property :yum_baseurl, String, default: 'https://bintray.com/sbt/rpm/rpm'
# Common settings
property :install_version, String

action :install do

  case node['platform_family']
  when 'rhel'
    yum_repository 'sbt' do
      description "Sbt Stable repo"
      baseurl yum_baseurl
      action :create
    end
  when 'debian'
    execute 'apt-get update' do
      command 'apt-get update'
      action :nothing
    end
    apt_repository 'sbt' do
      uri apt_uri
      key apt_key
      components ['/']
      keyserver apt_keyserver
      action :add
      notifies :run, 'execute[apt-get update]', :immediately
    end
  else
    log 'unsupported os' do
      message "This cookbook only works with platform_family 'debian' and 'rhel', detected #{node['platform_family']}"
      level :fatal
    end
  end

  # sbt has soo many of dependencies, this could take a very long time.
  if "#{install_version}"
    package 'sbt' do
      version install_version
      timeout 900
      action :install
    end
  else
    package 'sbt' do
      timeout 900
      action :install
    end
  end

end
