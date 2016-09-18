require boxen::environment
require homebrew
require gcc

include profile::bash
include profile::osx
include profile::tmux
include profile::vundle
include profile::vim
# include profile::vagrant-instant-rsync-auto

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::homebrewdir}/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  nodejs::version { '0.12': }

  class { 'nodejs::global':
    version => '0.12',
  }

  # A terminal-to-gif recorder
  npm_module { 'ttystudio for 0.12':
    module        => 'ttystudio',
    version       => '~> 0.0.16',
    node_version  => '0.12',
  }

  # default ruby versions
  ruby::version { '2.0.0': }
  ruby::version { '2.1.8': }
  ruby::version { '2.3.0': }

  ruby_gem { 'bropages for ruby 2.3.0':
    gem          => 'bropages',
    version      => '~> 0.1.0',
    ruby_version => '2.3.0',
  }

  ruby_gem { 'pry for ruby 2.3.0':
    gem          => 'pry',
    version      => '~> 0.10.4',
    ruby_version => '2.3.0',
  }

  # ruby_gem { 'chef for a ruby 2.3.1':
  #   gem          => 'chef',
  #   version      => '~> 12.4.3',
  #   ruby_version => '2.3.1',
  # }

  # ruby_gem { 'knife-github for a ruby 2.3.1':
  #   gem          => 'knife-github-cookbooks',
  #   version      => '~> 0.1.8',
  #   ruby_version => '2.3.1',
  # }

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar',
      'macvim',
      'cmake',
      'vim',
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}


# additional modules

atom::package {
  [
    'linter',
    'markdown-pdf',
    'multi-cursor',
    'markdown-preview',
    'markdown-sort-list',
    'markdown-preview-opener',
    'markdown-table-formatter',
    'markdown-format',
    'linter-markdown',
    'markdown-scroll-sync',
    'markdown-helpers',
    'dash',
    'language-puppet',
    'language-chef',
  ]:
}

atom::theme { 'monokai': }

#configure git
git::config::global { 'user.email':
  value  => 'beresfordjunior@me.com'
}
git::config::global { 'user.name':
  value  => 'Ralph Reid'
}

git::config::global { 'push.default':
  value => 'simple'
}

package {
  [
    'paw',
    'google-chrome',
    'google-drive',
    'postbox',
    'dropbox',
    'iterm2',
    'evernote',
    'skype',
    'slack',
    'recordit',
  ]: provider => 'brewcask'
}

package {
  ['asciinema', # Enables screencast recording
    'wget',
    'ssh-copy-id',
    'spark', # Required for tmux battery in status-right
    'keychain', # add eval $(keychain --eval ~/.ssh/<your key's name>) to .bash_profile or shell's profile
  ]:
}

# Vagrant configs
class { 'vagrant': }
vagrant::plugin { [
  'hostmanager',
  'r10k',
  'faster',
  'vbox-snapshot',
  'omnibus', # Required to avoid chef errors
  ]: }
