# frozen_string_literal: true

Pod::Spec.new do |s|
  s.name          = 'wpxmlrpc'
  s.version       = '0.9.0'

  s.summary       = 'Lightweight XML-RPC library.'
  s.description   = <<-DESC
                    This framework contains a very lightweight XML-RPC library, allowing you to encode and decode XML-RPC request payloads.
  DESC

  s.homepage      = 'https://github.com/wordpress-mobile/wpxmlrpc'
  s.license       = { type: 'MIT', file: 'LICENSE.md' }
  s.author        = { 'The WordPress Mobile Team' => 'mobile@wordpress.org' }

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '9.0'
  s.swift_version = '5.0'

  s.source        = { git: 'https://github.com/wordpress-mobile/wpxmlrpc.git', tag: s.version.to_s }
  s.source_files  = 'WPXMLRPC'
  s.public_header_files = ['WPXMLRPC/WPXMLRPC.h', 'WPXMLRPC/WPXMLRPCEncoder.h', 'WPXMLRPC/WPXMLRPCDecoder.h']
  s.libraries = 'iconv'

  s.test_spec do |test|
    test.source_files = 'WPXMLRPCTest/Tests/*.{h,m}'
    test.resources = 'WPXMLRPCTest/Test Data/*'
  end
end
