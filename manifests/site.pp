require boxen::environment
require homebrew
require gcc

include profile::bash
include profile::tmux
include profile::vundle
include profile::vim
include profile::vagrant-instant-rsync-auto

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
  nodejs::version { '0.8': }
  nodejs::version { '0.10': }
  nodejs::version { '0.12': }

  # default ruby versions
  ruby::version { '1.9.3': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.8': }
  ruby::version { '2.2.2': }
  ruby::version { '2.3.0': }
  ruby::version { '2.3.1': }

  ruby_gem { 'bropages for all rubies':
    gem          => 'bropages',
    version      => '~> 0.1.0',
    ruby_version => '*',
  }

  ruby_gem { 'mkpasswd for all rubies':
    gem          => 'mkpasswd',
    version      => '~> 0.1.0',
    ruby_version => '*',
  }

  ruby_gem { 'bundler for all rubies':
    gem          => 'bundler',
    version      => '~> 1.0',
    ruby_version => '*',
  }

  ruby_gem { 'chef for all rubies':
    gem          => 'chef',
    version      => '~> 12.4.3',
    ruby_version => '2.2.2',
  }

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
    'linter-foodcritic',
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
    'postbox',
    'dropbox',
    'iterm2',
    'evernote',
    'pycharm',
    'skype',
    'hipchat',
    'slack',
    'virtualbox', #may require manual install
    'box-sync',
    'dockertoolbox', #may require manual install
    'rubymine',
    'recordit',
    'google-drive',
    'tunnelblick', # open vpn client
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
