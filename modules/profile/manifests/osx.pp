class profile::osx {

  include osx::global::tap_to_click

  # Dock Settings
  include osx::dock::autohide
  class { 'osx::dock::position': position => 'left' }
  # Public: Enable one or two button mode for multitouch mice (default = 1).
  # Requires re-login.
  class { 'osx::mouse::button_mode': mode => 2 }
}
