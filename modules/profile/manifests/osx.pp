class profile::osx {

  include osx::global::tap_to_click

  # Dock Settings
  include osx::dock::autohide
  class { 'osx::dock::position':
    position => 'left'
  }
}
