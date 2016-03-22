class profile::vim {

  file { ".vmrc":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vimrc",
    content => template('profile/vimrc.erb'),
  }

  file { "ftdetect":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/ftdetect.vim",
    content => template('profile/vim/ftdetect.vim.erb'),
  }

  file { "ftplugin":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/ftplugin.vim",
    content => template('profile/vim/ftplugin.vim.erb'),
  }

  file { "indent":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/indent.vim",
    content => template('profile/vim/indent.vim.erb'),
  }

  file { "syntax":
    ensure  => file,
    path    => "/Users/${::boxen_user}/.vim/syntax.vim",
    content => template('profile/vim/syntax.vim.erb'),
  }

}
