class profile::bash {

  # Installs bash-it goes here

  file { ".bash_profile":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.bash_profile",
    content => template('profile/bash_profile.erb'),
  }

}
