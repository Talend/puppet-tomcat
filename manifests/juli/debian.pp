class tomcat::juli::debian {

  $url =[
    $tomcat::sources_src,
    "tomcat-${tomcat::version}",
    "v${tomcat::src_version}",
    'bin',
  ]

  $baseurl = inline_template('<%=@url.join("/")%>')

  $require = $::tomcat::sources ? {
    true => undef,
    false  => Package['tomcat'],
  }

  file { "${tomcat::home}/extras/":
    ensure  => directory,
    require => $require,
  }

  archive { "${tomcat::home}/extras/tomcat-juli.jar":
    source        => "${baseurl}/extras/tomcat-juli.jar",
    checksum_url  => "${baseurl}/extras/tomcat-juli.jar.md5",
    checksum_type => 'md5',
    extract_path  => "${tomcat::home}/extras/",
    require       => File["${tomcat::home}/extras/"],
    extract       => false
  }

  archive { "${tomcat::home}/extras/tomcat-juli-adapters.jar":
    source        => "${baseurl}/extras/tomcat-juli-adapters.jar",
    checksum_url  => "${baseurl}/extras/tomcat-juli-adapters.jar.md5",
    checksum_type => 'md5',
    extract_path  => "${tomcat::home}/extras/",
    require       => File["${tomcat::home}/extras/"],
  }

  file { "${tomcat::home}/bin/tomcat-juli.jar":
    ensure  => link,
    target  => "${tomcat::home}/extras/tomcat-juli.jar",
    require => Archive["${tomcat::home}/extras/tomcat-juli.jar"],
  }

  file { "${tomcat::home}/lib/tomcat-juli-adapters.jar":
    ensure  => link,
    target  => "${tomcat::home}/extras/tomcat-juli-adapters.jar",
    require => Archive["${tomcat::home}/extras/tomcat-juli-adapters.jar"],
  }

}
