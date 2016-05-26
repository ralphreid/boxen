class profile::vagrant-instant-rsync-auto {

  # Installs rync update
  homebrew::tap { 'homebrew/dupes': }
  package { 'rsync': }

  vagrant::plugin { 'vagrant-instant-rsync-auto':
    require => Package['rsync'],
  }
}
