class profile::tmux {

  # tmux configuration
  file { "tmux.conf":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.tmux.conf",
    content => template('profile/tmux.conf.erb'),
  }

}
