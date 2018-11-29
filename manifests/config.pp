#  Configures fetch-crl
#
# @api private
#
class fetchcrl::config (
  $agingtolerance        = $fetchcrl::agingtolerance,
  $nosymlinks            = $fetchcrl::nosymlinks,
  $nowarnings            = $fetchcrl::nowarnings,
  $http_proxy            = $fetchcrl::http_proxy,
  $httptimeout           = $fetchcrl::httptimeout,
  $parallelism           = $fetchcrl::parallelism,
  $logmode               = $fetchcrl::logmode,
  $pkgname               = $fetchcrl::pkgname,
  $cache_control_request = $fetchcrl::cache_control_request,
) {

  assert_private()

  file{"/etc/${pkgname}.conf":
    ensure  => present,
    content => epp('fetchcrl/fetch-crl.conf.epp',{
      'agingtolerance'        => $agingtolerance,
      'nosymlinks'            => $nosymlinks,
      'nowarnings'            => $nowarnings,
      'http_proxy'            => $http_proxy,
      'httptimeout'           => $httptimeout,
      'parallelism'           => $parallelism,
      'logmode'               => $logmode,
      'cache_control_request' => $cache_control_request,
    }),
    mode    => '0644',
    owner   => root,
    group   => root,
  }

  # Keep the directory based configuration empty.
  file{"/etc/${pkgname}.d":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    purge   => true,
    force   => true,
    recurse => true,
  }

}
