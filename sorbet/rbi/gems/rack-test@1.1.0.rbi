# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rack-test` gem.
# Please instead update this file by running `bin/tapioca gem rack-test`.

# source://rack-test//lib/rack/mock_session.rb#1
module Rack
  class << self
    # source://rack/2.2.3/lib/rack/version.rb#26
    def release; end

    # source://rack/2.2.3/lib/rack/version.rb#19
    def version; end
  end
end

# source://rack/2.2.3/lib/rack.rb#29
Rack::CACHE_CONTROL = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#31
Rack::CONTENT_LENGTH = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#32
Rack::CONTENT_TYPE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#43
Rack::DELETE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#36
Rack::ETAG = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#30
Rack::EXPIRES = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack/file.rb#6
Rack::File = Rack::Files

# source://rack/2.2.3/lib/rack.rb#39
Rack::GET = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#44
Rack::HEAD = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#20
Rack::HTTPS = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#35
Rack::HTTP_COOKIE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#17
Rack::HTTP_HOST = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#18
Rack::HTTP_PORT = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#19
Rack::HTTP_VERSION = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#46
Rack::LINK = T.let(T.unsafe(nil), String)

# source://rack-test//lib/rack/mock_session.rb#2
class Rack::MockSession
  # @return [MockSession] a new instance of MockSession
  #
  # source://rack-test//lib/rack/mock_session.rb#6
  def initialize(app, default_host = T.unsafe(nil)); end

  # source://rack-test//lib/rack/mock_session.rb#14
  def after_request(&block); end

  # source://rack-test//lib/rack/mock_session.rb#18
  def clear_cookies; end

  # source://rack-test//lib/rack/mock_session.rb#59
  def cookie_jar; end

  # Sets the attribute cookie_jar
  #
  # @param value the value to set the attribute cookie_jar to.
  #
  # source://rack-test//lib/rack/mock_session.rb#3
  def cookie_jar=(_arg0); end

  # Returns the value of attribute default_host.
  #
  # source://rack-test//lib/rack/mock_session.rb#4
  def default_host; end

  # Return the last request issued in the session. Raises an error if no
  # requests have been sent yet.
  #
  # @raise [Rack::Test::Error]
  #
  # source://rack-test//lib/rack/mock_session.rb#47
  def last_request; end

  # Return the last response received in the session. Raises an error if
  # no requests have been sent yet.
  #
  # @raise [Rack::Test::Error]
  #
  # source://rack-test//lib/rack/mock_session.rb#54
  def last_response; end

  # source://rack-test//lib/rack/mock_session.rb#26
  def request(uri, env); end

  # source://rack-test//lib/rack/mock_session.rb#22
  def set_cookie(cookie, uri = T.unsafe(nil)); end
end

# source://rack/2.2.3/lib/rack.rb#45
Rack::OPTIONS = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#42
Rack::PATCH = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#21
Rack::PATH_INFO = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#40
Rack::POST = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#41
Rack::PUT = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#25
Rack::QUERY_STRING = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#53
Rack::RACK_ERRORS = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#63
Rack::RACK_HIJACK = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#65
Rack::RACK_HIJACK_IO = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#55
Rack::RACK_INPUT = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#64
Rack::RACK_IS_HIJACK = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#54
Rack::RACK_LOGGER = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#76
Rack::RACK_METHODOVERRIDE_ORIGINAL_METHOD = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#67
Rack::RACK_MULTIPART_BUFFER_SIZE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#68
Rack::RACK_MULTIPART_TEMPFILE_FACTORY = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#60
Rack::RACK_MULTIPROCESS = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#59
Rack::RACK_MULTITHREAD = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#66
Rack::RACK_RECURSIVE_INCLUDE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#72
Rack::RACK_REQUEST_COOKIE_HASH = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#73
Rack::RACK_REQUEST_COOKIE_STRING = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#70
Rack::RACK_REQUEST_FORM_HASH = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#69
Rack::RACK_REQUEST_FORM_INPUT = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#71
Rack::RACK_REQUEST_FORM_VARS = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#74
Rack::RACK_REQUEST_QUERY_HASH = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#75
Rack::RACK_REQUEST_QUERY_STRING = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#61
Rack::RACK_RUNONCE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#56
Rack::RACK_SESSION = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#57
Rack::RACK_SESSION_OPTIONS = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#77
Rack::RACK_SESSION_UNPACKED_COOKIE_DATA = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#58
Rack::RACK_SHOWSTATUS_DETAIL = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#52
Rack::RACK_TEMPFILES = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#62
Rack::RACK_URL_SCHEME = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#51
Rack::RACK_VERSION = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack/version.rb#23
Rack::RELEASE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#22
Rack::REQUEST_METHOD = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#23
Rack::REQUEST_PATH = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#24
Rack::SCRIPT_NAME = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#27
Rack::SERVER_NAME = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#28
Rack::SERVER_PORT = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#26
Rack::SERVER_PROTOCOL = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#33
Rack::SET_COOKIE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#48
Rack::TRACE = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#34
Rack::TRANSFER_ENCODING = T.let(T.unsafe(nil), String)

# source://rack-test//lib/rack/test/cookie_jar.rb#5
module Rack::Test
  class << self
    # @return [Boolean]
    #
    # source://rack-test//lib/rack/test.rb#330
    def encoding_aware_strings?; end
  end
end

# source://rack-test//lib/rack/test/cookie_jar.rb#6
class Rack::Test::Cookie
  include ::Rack::Utils

  # :api: private
  #
  # @return [Cookie] a new instance of Cookie
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#13
  def initialize(raw, uri = T.unsafe(nil), default_host = T.unsafe(nil)); end

  # :api: private
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#87
  def <=>(other); end

  # :api: private
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#42
  def domain; end

  # :api: private
  #
  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#37
  def empty?; end

  # :api: private
  #
  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#65
  def expired?; end

  # :api: private
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#60
  def expires; end

  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#50
  def http_only?; end

  # :api: private
  #
  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#82
  def matches?(uri); end

  # :api: private
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#10
  def name; end

  # :api: private
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#55
  def path; end

  # :api: private
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#32
  def raw; end

  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#27
  def replaces?(other); end

  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#46
  def secure?; end

  # source://rack-test//lib/rack/test/cookie_jar.rb#92
  def to_h; end

  # source://rack-test//lib/rack/test/cookie_jar.rb#92
  def to_hash; end

  # :api: private
  #
  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#70
  def valid?(uri); end

  # :api: private
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#10
  def value; end

  protected

  # source://rack-test//lib/rack/test/cookie_jar.rb#103
  def default_uri; end
end

# source://rack-test//lib/rack/test/cookie_jar.rb#108
class Rack::Test::CookieJar
  # :api: private
  #
  # @return [CookieJar] a new instance of CookieJar
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#112
  def initialize(cookies = T.unsafe(nil), default_host = T.unsafe(nil)); end

  # source://rack-test//lib/rack/test/cookie_jar.rb#152
  def <<(new_cookie); end

  # source://rack-test//lib/rack/test/cookie_jar.rb#118
  def [](name); end

  # source://rack-test//lib/rack/test/cookie_jar.rb#124
  def []=(name, value); end

  # source://rack-test//lib/rack/test/cookie_jar.rb#132
  def delete(name); end

  # :api: private
  #
  # source://rack-test//lib/rack/test/cookie_jar.rb#162
  def for(uri); end

  # source://rack-test//lib/rack/test/cookie_jar.rb#128
  def get_cookie(name); end

  # source://rack-test//lib/rack/test/cookie_jar.rb#138
  def merge(raw_cookies, uri = T.unsafe(nil)); end

  # source://rack-test//lib/rack/test/cookie_jar.rb#166
  def to_hash; end

  protected

  # source://rack-test//lib/rack/test/cookie_jar.rb#178
  def hash_for(uri = T.unsafe(nil)); end
end

# source://rack-test//lib/rack/test/cookie_jar.rb#109
Rack::Test::CookieJar::DELIMITER = T.let(T.unsafe(nil), String)

# source://rack-test//lib/rack/test.rb#13
Rack::Test::DEFAULT_HOST = T.let(T.unsafe(nil), String)

# The common base class for exceptions raised by Rack::Test
#
# source://rack-test//lib/rack/test.rb#17
class Rack::Test::Error < ::StandardError; end

# source://rack-test//lib/rack/test.rb#14
Rack::Test::MULTIPART_BOUNDARY = T.let(T.unsafe(nil), String)

# This module serves as the primary integration point for using Rack::Test
# in a testing environment. It depends on an app method being defined in the
# same context, and provides the Rack::Test API methods (see Rack::Test::Session
# for their documentation).
#
# Example:
#
#   class HomepageTest < Test::Unit::TestCase
#     include Rack::Test::Methods
#
#     def app
#       MyApp.new
#     end
#   end
#
# source://rack-test//lib/rack/test/methods.rb#19
module Rack::Test::Methods
  extend ::Forwardable

  # source://rack-test//lib/rack/test/methods.rb#54
  def _current_session_names; end

  # source://forwardable/1.3.2/forwardable.rb#229
  def authorize(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def basic_authorize(*args, **_arg1, &block); end

  # source://rack-test//lib/rack/test/methods.rb#29
  def build_rack_mock_session; end

  # source://rack-test//lib/rack/test/methods.rb#40
  def build_rack_test_session(name); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def clear_cookies(*args, **_arg1, &block); end

  # source://rack-test//lib/rack/test/methods.rb#44
  def current_session; end

  # source://forwardable/1.3.2/forwardable.rb#229
  def custom_request(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def delete(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def digest_authorize(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def env(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def follow_redirect!(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def get(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def head(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def header(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def last_request(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def last_response(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def options(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def patch(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def post(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def put(*args, **_arg1, &block); end

  # source://rack-test//lib/rack/test/methods.rb#22
  def rack_mock_session(name = T.unsafe(nil)); end

  # source://rack-test//lib/rack/test/methods.rb#33
  def rack_test_session(name = T.unsafe(nil)); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def request(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def set_cookie(*args, **_arg1, &block); end

  # @yield [rack_test_session(name)]
  #
  # source://rack-test//lib/rack/test/methods.rb#48
  def with_session(name); end
end

# source://rack-test//lib/rack/test/methods.rb#58
Rack::Test::Methods::METHODS = T.let(T.unsafe(nil), Array)

# source://rack-test//lib/rack/test/mock_digest_request.rb#3
class Rack::Test::MockDigestRequest
  # @return [MockDigestRequest] a new instance of MockDigestRequest
  #
  # source://rack-test//lib/rack/test/mock_digest_request.rb#4
  def initialize(params); end

  # source://rack-test//lib/rack/test/mock_digest_request.rb#16
  def method; end

  # source://rack-test//lib/rack/test/mock_digest_request.rb#8
  def method_missing(sym); end

  # source://rack-test//lib/rack/test/mock_digest_request.rb#20
  def response(password); end
end

# This class represents a series of requests issued to a Rack app, sharing
# a single cookie jar
#
# Rack::Test::Session's methods are most often called through Rack::Test::Methods,
# which will automatically build a session when it's first used.
#
# source://rack-test//lib/rack/test.rb#24
class Rack::Test::Session
  include ::Rack::Utils
  include ::Rack::Test::Utils
  extend ::Forwardable

  # Creates a Rack::Test::Session for a given Rack app or Rack::MockSession.
  #
  # Note: Generally, you won't need to initialize a Rack::Test::Session directly.
  # Instead, you should include Rack::Test::Methods into your testing context.
  # (See README.rdoc for an example)
  #
  # @return [Session] a new instance of Session
  #
  # source://rack-test//lib/rack/test.rb#35
  def initialize(mock_session); end

  # Set the username and password for HTTP Basic authorization, to be
  # included in subsequent requests in the HTTP_AUTHORIZATION header.
  #
  # Example:
  #   basic_authorize "bryan", "secret"
  #
  # source://rack-test//lib/rack/test.rb#166
  def authorize(username, password); end

  # Set the username and password for HTTP Basic authorization, to be
  # included in subsequent requests in the HTTP_AUTHORIZATION header.
  #
  # Example:
  #   basic_authorize "bryan", "secret"
  #
  # source://rack-test//lib/rack/test.rb#166
  def basic_authorize(username, password); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def clear_cookies(*args, **_arg1, &block); end

  # Issue a request using the given verb for the given URI. See #get
  #
  # Example:
  #   custom_request "LINK", "/"
  #
  # source://rack-test//lib/rack/test.rb#126
  def custom_request(verb, uri, params = T.unsafe(nil), env = T.unsafe(nil), &block); end

  # Issue a DELETE request for the given URI. See #get
  #
  # Example:
  #   delete "/"
  #
  # source://rack-test//lib/rack/test.rb#89
  def delete(uri, params = T.unsafe(nil), env = T.unsafe(nil), &block); end

  # Set the username and password for HTTP Digest authorization, to be
  # included in subsequent requests in the HTTP_AUTHORIZATION header.
  #
  # Example:
  #   digest_authorize "bryan", "secret"
  #
  # source://rack-test//lib/rack/test.rb#178
  def digest_authorize(username, password); end

  # Set an env var to be included on all subsequent requests through the
  # session. Use a value of nil to remove a previously configured env.
  #
  # Example:
  #   env "rack.session", {:csrf => 'token'}
  #
  # source://rack-test//lib/rack/test.rb#153
  def env(name, value); end

  # Rack::Test will not follow any redirects automatically. This method
  # will follow the redirect returned (including setting the Referer header
  # on the new request) in the last response. If the last response was not
  # a redirect, an error will be raised.
  #
  # source://rack-test//lib/rack/test.rb#187
  def follow_redirect!; end

  # Issue a GET request for the given URI with the given params and Rack
  # environment. Stores the issues request object in #last_request and
  # the app's response in #last_response. Yield #last_response to a block
  # if given.
  #
  # Example:
  #   get "/"
  #
  # source://rack-test//lib/rack/test.rb#57
  def get(uri, params = T.unsafe(nil), env = T.unsafe(nil), &block); end

  # Issue a HEAD request for the given URI. See #get
  #
  # Example:
  #   head "/"
  #
  # source://rack-test//lib/rack/test.rb#105
  def head(uri, params = T.unsafe(nil), env = T.unsafe(nil), &block); end

  # Set a header to be included on all subsequent requests through the
  # session. Use a value of nil to remove a previously configured header.
  #
  # In accordance with the Rack spec, headers will be included in the Rack
  # environment hash in HTTP_USER_AGENT form.
  #
  # Example:
  #   header "User-Agent", "Firefox"
  #
  # source://rack-test//lib/rack/test.rb#140
  def header(name, value); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def last_request(*args, **_arg1, &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def last_response(*args, **_arg1, &block); end

  # Issue an OPTIONS request for the given URI. See #get
  #
  # Example:
  #   options "/"
  #
  # source://rack-test//lib/rack/test.rb#97
  def options(uri, params = T.unsafe(nil), env = T.unsafe(nil), &block); end

  # Issue a PATCH request for the given URI. See #get
  #
  # Example:
  #   patch "/"
  #
  # source://rack-test//lib/rack/test.rb#81
  def patch(uri, params = T.unsafe(nil), env = T.unsafe(nil), &block); end

  # Issue a POST request for the given URI. See #get
  #
  # Example:
  #   post "/signup", "name" => "Bryan"
  #
  # source://rack-test//lib/rack/test.rb#65
  def post(uri, params = T.unsafe(nil), env = T.unsafe(nil), &block); end

  # Issue a PUT request for the given URI. See #get
  #
  # Example:
  #   put "/"
  #
  # source://rack-test//lib/rack/test.rb#73
  def put(uri, params = T.unsafe(nil), env = T.unsafe(nil), &block); end

  # Issue a request to the Rack app for the given URI and optional Rack
  # environment. Stores the issues request object in #last_request and
  # the app's response in #last_response. Yield #last_response to a block
  # if given.
  #
  # Example:
  #   request "/"
  #
  # source://rack-test//lib/rack/test.rb#116
  def request(uri, env = T.unsafe(nil), &block); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def set_cookie(*args, **_arg1, &block); end

  private

  # source://rack-test//lib/rack/test.rb#305
  def default_env; end

  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test.rb#301
  def digest_auth_configured?; end

  # source://rack-test//lib/rack/test.rb#280
  def digest_auth_header; end

  # source://rack-test//lib/rack/test.rb#221
  def env_for(uri, env); end

  # source://rack-test//lib/rack/test.rb#309
  def headers_for_env; end

  # source://rack-test//lib/rack/test.rb#321
  def params_to_string(params); end

  # source://rack-test//lib/rack/test.rb#213
  def parse_uri(path, env); end

  # source://rack-test//lib/rack/test.rb#265
  def process_request(uri, env); end

  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test.rb#295
  def retry_with_digest_auth?(env); end
end

# Wraps a Tempfile with a content type. Including one or more UploadedFile's
# in the params causes Rack::Test to build and issue a multipart request.
#
# Example:
#   post "/photos", "file" => Rack::Test::UploadedFile.new("me.jpg", "image/jpeg")
#
# source://rack-test//lib/rack/test/uploaded_file.rb#12
class Rack::Test::UploadedFile
  # Creates a new UploadedFile instance.
  #
  # @param content [IO, Pathname, String, StringIO] a path to a file, or an {IO} or {StringIO} object representing the
  #   file.
  # @param content_type [String]
  # @param binary [Boolean] an optional flag that indicates whether the file should be open in binary mode or not.
  # @param original_filename [String] an optional parameter that provides the original filename if `content` is a StringIO
  #   object. Not used for other kind of `content` objects.
  # @return [UploadedFile] a new instance of UploadedFile
  #
  # source://rack-test//lib/rack/test/uploaded_file.rb#30
  def initialize(content, content_type = T.unsafe(nil), binary = T.unsafe(nil), original_filename: T.unsafe(nil)); end

  # The content type of the "uploaded" file
  #
  # source://rack-test//lib/rack/test/uploaded_file.rb#20
  def content_type; end

  # The content type of the "uploaded" file
  #
  # source://rack-test//lib/rack/test/uploaded_file.rb#20
  def content_type=(_arg0); end

  # source://rack-test//lib/rack/test/uploaded_file.rb#40
  def local_path; end

  # source://rack-test//lib/rack/test/uploaded_file.rb#46
  def method_missing(method_name, *args, &block); end

  # The filename, *not* including the path, of the "uploaded" file
  #
  # source://rack-test//lib/rack/test/uploaded_file.rb#14
  def original_filename; end

  # source://rack-test//lib/rack/test/uploaded_file.rb#40
  def path; end

  # The tempfile
  #
  # source://rack-test//lib/rack/test/uploaded_file.rb#17
  def tempfile; end

  private

  # source://rack-test//lib/rack/test/uploaded_file.rb#70
  def initialize_from_file_path(path); end

  # source://rack-test//lib/rack/test/uploaded_file.rb#65
  def initialize_from_stringio(stringio, original_filename); end

  # @return [Boolean]
  #
  # source://rack-test//lib/rack/test/uploaded_file.rb#50
  def respond_to_missing?(method_name, include_private = T.unsafe(nil)); end

  class << self
    # source://rack-test//lib/rack/test/uploaded_file.rb#58
    def actually_finalize(file); end

    # source://rack-test//lib/rack/test/uploaded_file.rb#54
    def finalize(file); end
  end
end

# source://rack-test//lib/rack/test/utils.rb#3
module Rack::Test::Utils
  include ::Rack::Utils
  extend ::Rack::Utils

  private

  # source://rack-test//lib/rack/test/utils.rb#130
  def build_file_part(parameter_name, uploaded_file); end

  # source://rack-test//lib/rack/test/utils.rb#30
  def build_multipart(params, first = T.unsafe(nil), multipart = T.unsafe(nil)); end

  # source://rack-test//lib/rack/test/utils.rb#7
  def build_nested_query(value, prefix = T.unsafe(nil)); end

  # source://rack-test//lib/rack/test/utils.rb#86
  def build_parts(parameters); end

  # source://rack-test//lib/rack/test/utils.rb#117
  def build_primitive_part(parameter_name, value); end

  # source://rack-test//lib/rack/test/utils.rb#91
  def get_parts(parameters); end

  class << self
    # source://rack-test//lib/rack/test/utils.rb#130
    def build_file_part(parameter_name, uploaded_file); end

    # source://rack-test//lib/rack/test/utils.rb#30
    def build_multipart(params, first = T.unsafe(nil), multipart = T.unsafe(nil)); end

    # source://rack-test//lib/rack/test/utils.rb#7
    def build_nested_query(value, prefix = T.unsafe(nil)); end

    # source://rack-test//lib/rack/test/utils.rb#86
    def build_parts(parameters); end

    # source://rack-test//lib/rack/test/utils.rb#117
    def build_primitive_part(parameter_name, value); end

    # source://rack-test//lib/rack/test/utils.rb#91
    def get_parts(parameters); end
  end
end

# source://rack-test//lib/rack/test/version.rb#3
Rack::Test::VERSION = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack.rb#47
Rack::UNLINK = T.let(T.unsafe(nil), String)

# source://rack/2.2.3/lib/rack/version.rb#16
Rack::VERSION = T.let(T.unsafe(nil), Array)
