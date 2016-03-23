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

  file { 'index_folder':
    ensure => directory,
    path => '/Users/${::boxen_user}/.vim/index',
  }

  file { 'syntax_folder':
    ensure => directory,
    path => '/Users/${::boxen_user}/.vim/syntax',
  }

  file { "ftdetect":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/ftdetect/puppet.vim",
    content => template('profile/vim/ftdetect.vim.erb'),
  }

  file { "ftplugin":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/ftplugin/puppet.vim",
    content => template('profile/vim/ftplugin.vim.erb'),
  }

  file { "indent":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/indent/puppet.vim",
    content => template('profile/vim/indent.vim.erb'),
  }

  file { "syntax":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/syntax/puppet.vim",
    content => template('profile/vim/syntax.vim.erb'),
  }

}
