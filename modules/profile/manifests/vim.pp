class profile::vim {

  file { ".vmrc":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vimrc",
    content => template('profile/vim/vimrc.erb'),
  }

  file { ".vmrc.settings":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vimrc.settings",
    content => template('profile/vim/vimrc.settings.erb'),
  }

  file { 'ftdetect_folder':
    ensure => directory,
    path => '/Users/${::boxen_user}/.vim/ftdetect',
  }

  file { 'ftplugin_folder':
    ensure => directory,
    path => '/Users/${::boxen_user}/.vim/ftplugin',
  }

  file { 'indent_folder':
    ensure => directory,
    path => '/Users/${::boxen_user}/.vim/indent',
  }

  file { 'syntax_folder':
    ensure => directory,
    path => '/Users/${::boxen_user}/.vim/syntax',
  }

  file { "ftdetect":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/ftdetect/puppet.vim",
    content => template('profile/vim/ftdetect.vim.erb'),
    require => 'ftdetect_folder',
  }

  file { "ftplugin":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/ftplugin/puppet.vim",
    content => template('profile/vim/ftplugin.vim.erb'),
    require => 'ftplugin_folder',
  }

  file { "indent":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/indent/puppet.vim",
    content => template('profile/vim/indent.vim.erb'),
    require => 'indent_folder',
  }

  file { "syntax":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/syntax/puppet.vim",
    content => template('profile/vim/syntax.vim.erb'),
    require => 'syntax_folder',
  }

}
