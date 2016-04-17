class profile::tmux {

  package { 'tmux': }

  # tmux configuration
  file { "tmux.conf":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.tmux.conf",
    source => "puppet:///profile/tmux.conf",
  }

}
