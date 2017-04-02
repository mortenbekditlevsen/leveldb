# CocoaPods 1.x currently does not support libraries with C++ headers. See
# https://github.com/CocoaPods/CocoaPods/issues/5152. The workaround is to use
# the 1.2.1.beta.1 with its new option --skip-import-validation.

# To update the pod:
#   Make changes
#   Update s.version below to {new version}
#   git tag '{new version}'
#   git push origin {branch_name} --tags
#   pod spec lint leveldb-firebase.podspec --skip-import-validation
#   pod repo push {test spec server} leveldb-firebase.podspec --skip-import-validation
#   test pod
#   Do pull request
#   pod trunk push leveldb-firebase.podspec --skip-import-validation

Pod::Spec.new do |s|
  s.name         =  'leveldb-firebase'
  s.version      =  '1.18.3'
  s.license      =  'New BSD'
  s.summary      =  'A fast key-value storage library'
  s.description  =  'LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.'
  s.homepage     =  'https://github.com/firebase/leveldb'
  s.authors      =  'The LevelDB Authors'

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'

  s.source       =  {
    :git => 'https://github.com/paulb777/leveldb.git', :tag => String(s.version)
  }

  s.requires_arc = false

  s.compiler_flags = '-DOS_MACOSX', '-DLEVELDB_PLATFORM_POSIX'

  s.preserve_path = 'db', 'port', 'table', 'util'

  s.xcconfig = {
    'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/leveldb-firebase/" "${PODS_ROOT}/leveldb-firebase/include"',
    'WARNING_CFLAGS' => '-Wno-shorten-64-to-32',
    'OTHER_LDFLAGS' => '-lc++'
  }

  s.header_dir = "leveldb"
  s.source_files = [
    "db/*.{cc}", "db/*.h",
    "port/*.{cc}", "port/*.h",
    "table/*.{cc}", "table/*.h",
    "util/*.{cc}", "util/*.h",
    "include/leveldb/*.h"
  ]

  s.exclude_files = [
    "**/*_test.cc",
    "**/*_bench.cc",
    "port/win"
  ]
end
