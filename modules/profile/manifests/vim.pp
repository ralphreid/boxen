class profile::vim {

  file { ".vmrc":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vimrc",
    content => template('profile/vimrc.erb'),
  }

}
