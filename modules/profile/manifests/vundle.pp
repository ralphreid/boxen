class profile::vundle {

  repository {
    'vundle source':
      source   => 'git://github.com/VundleVim/Vundle.vim.git',
      path     => "/Users/${::boxen_user}/.vim/bundle/Vundle.vim",
      provider => 'git',
  }

}
