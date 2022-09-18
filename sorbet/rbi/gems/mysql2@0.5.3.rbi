# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `mysql2` gem.
# Please instead update this file by running `bin/tapioca gem mysql2`.

# For holding utility methods
#
# source://mysql2//lib/mysql2/version.rb#1
module Mysql2; end

# source://mysql2//lib/mysql2/client.rb#2
class Mysql2::Client
  # @raise [Mysql2::Error]
  # @return [Client] a new instance of Client
  #
  # source://mysql2//lib/mysql2/client.rb#21
  def initialize(opts = T.unsafe(nil)); end

  def abandon_results!; end
  def affected_rows; end
  def async_result; end
  def automatic_close=(_arg0); end
  def automatic_close?; end
  def close; end
  def closed?; end
  def encoding; end
  def escape(_arg0); end

  # source://mysql2//lib/mysql2/client.rb#143
  def info; end

  def last_id; end
  def more_results?; end
  def next_result; end

  # Set default program_name in performance_schema.session_connect_attrs
  # and performance_schema.session_account_connect_attrs
  #
  # source://mysql2//lib/mysql2/client.rb#120
  def parse_connect_attrs(conn_attrs); end

  # source://mysql2//lib/mysql2/client.rb#104
  def parse_flags_array(flags, initial = T.unsafe(nil)); end

  # source://mysql2//lib/mysql2/client.rb#93
  def parse_ssl_mode(mode); end

  def ping; end
  def prepare(_arg0); end

  # source://mysql2//lib/mysql2/client.rb#129
  def query(sql, options = T.unsafe(nil)); end

  # source://mysql2//lib/mysql2/client.rb#135
  def query_info; end

  def query_info_string; end

  # Returns the value of attribute query_options.
  #
  # source://mysql2//lib/mysql2/client.rb#3
  def query_options; end

  # Returns the value of attribute read_timeout.
  #
  # source://mysql2//lib/mysql2/client.rb#3
  def read_timeout; end

  def reconnect=(_arg0); end
  def select_db(_arg0); end
  def server_info; end
  def set_server_option(_arg0); end
  def socket; end
  def ssl_cipher; end
  def store_result; end
  def thread_id; end
  def warning_count; end

  private

  def _query(_arg0, _arg1); end
  def charset_name=(_arg0); end
  def connect(_arg0, _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7); end
  def connect_timeout=(_arg0); end
  def default_auth=(_arg0); end
  def default_file=(_arg0); end
  def default_group=(_arg0); end
  def enable_cleartext_plugin=(_arg0); end
  def init_command=(_arg0); end
  def initialize_ext; end
  def local_infile=(_arg0); end
  def read_timeout=(_arg0); end
  def secure_auth=(_arg0); end
  def ssl_mode=(_arg0); end
  def ssl_set(_arg0, _arg1, _arg2, _arg3, _arg4); end
  def write_timeout=(_arg0); end

  class << self
    # source://mysql2//lib/mysql2/client.rb#5
    def default_query_options; end

    def escape(_arg0); end
    def info; end

    private

    # source://mysql2//lib/mysql2/client.rb#150
    def local_offset; end
  end
end

Mysql2::Client::ALL_FLAGS = T.let(T.unsafe(nil), Integer)
Mysql2::Client::BASIC_FLAGS = T.let(T.unsafe(nil), Integer)
Mysql2::Client::COMPRESS = T.let(T.unsafe(nil), Integer)
Mysql2::Client::CONNECT_ATTRS = T.let(T.unsafe(nil), Integer)
Mysql2::Client::CONNECT_WITH_DB = T.let(T.unsafe(nil), Integer)
Mysql2::Client::FOUND_ROWS = T.let(T.unsafe(nil), Integer)
Mysql2::Client::IGNORE_SIGPIPE = T.let(T.unsafe(nil), Integer)
Mysql2::Client::IGNORE_SPACE = T.let(T.unsafe(nil), Integer)
Mysql2::Client::INTERACTIVE = T.let(T.unsafe(nil), Integer)
Mysql2::Client::LOCAL_FILES = T.let(T.unsafe(nil), Integer)
Mysql2::Client::LONG_FLAG = T.let(T.unsafe(nil), Integer)
Mysql2::Client::LONG_PASSWORD = T.let(T.unsafe(nil), Integer)
Mysql2::Client::MULTI_STATEMENTS = T.let(T.unsafe(nil), Integer)
Mysql2::Client::NO_SCHEMA = T.let(T.unsafe(nil), Integer)
Mysql2::Client::ODBC = T.let(T.unsafe(nil), Integer)
Mysql2::Client::OPTION_MULTI_STATEMENTS_OFF = T.let(T.unsafe(nil), Integer)
Mysql2::Client::OPTION_MULTI_STATEMENTS_ON = T.let(T.unsafe(nil), Integer)
Mysql2::Client::PROTOCOL_41 = T.let(T.unsafe(nil), Integer)
Mysql2::Client::PS_MULTI_RESULTS = T.let(T.unsafe(nil), Integer)
Mysql2::Client::REMEMBER_OPTIONS = T.let(T.unsafe(nil), Integer)
Mysql2::Client::RESERVED = T.let(T.unsafe(nil), Integer)
Mysql2::Client::SECURE_CONNECTION = T.let(T.unsafe(nil), Integer)
Mysql2::Client::SSL = T.let(T.unsafe(nil), Integer)
Mysql2::Client::SSL_MODE_DISABLED = T.let(T.unsafe(nil), Integer)
Mysql2::Client::SSL_MODE_PREFERRED = T.let(T.unsafe(nil), Integer)
Mysql2::Client::SSL_MODE_REQUIRED = T.let(T.unsafe(nil), Integer)
Mysql2::Client::SSL_MODE_VERIFY_CA = T.let(T.unsafe(nil), Integer)
Mysql2::Client::SSL_MODE_VERIFY_IDENTITY = T.let(T.unsafe(nil), Integer)
Mysql2::Client::SSL_VERIFY_SERVER_CERT = T.let(T.unsafe(nil), Integer)
Mysql2::Client::TRANSACTIONS = T.let(T.unsafe(nil), Integer)

# source://mysql2//lib/mysql2/error.rb#2
class Mysql2::Error < ::StandardError
  # @return [Error] a new instance of Error
  #
  # source://mysql2//lib/mysql2/error.rb#52
  def initialize(msg, server_version = T.unsafe(nil), error_number = T.unsafe(nil), sql_state = T.unsafe(nil)); end

  # Returns the value of attribute error_number.
  # Mysql gem compatibility
  #
  # source://mysql2//lib/mysql2/error.rb#46
  def errno; end

  def error; end

  # Returns the value of attribute error_number.
  #
  # source://mysql2//lib/mysql2/error.rb#46
  def error_number; end

  # Returns the value of attribute sql_state.
  #
  # source://mysql2//lib/mysql2/error.rb#46
  def sql_state; end

  private

  # In MySQL 5.5+ error messages are always constructed server-side as UTF-8
  # then returned in the encoding set by the `character_set_results` system
  # variable.
  #
  # See http://dev.mysql.com/doc/refman/5.5/en/charset-errors.html for
  # more context.
  #
  # Before MySQL 5.5 error message template strings are in whatever encoding
  # is associated with the error message language.
  # See http://dev.mysql.com/doc/refman/5.1/en/error-message-language.html
  # for more information.
  #
  # The issue is that the user-data inserted in the message could potentially
  # be in any encoding MySQL supports and is insert into the latin1, euckr or
  # koi8r string raw. Meaning there's a high probability the string will be
  # corrupt encoding-wise.
  #
  # See http://dev.mysql.com/doc/refman/5.1/en/charset-errors.html for
  # more information.
  #
  # So in an attempt to make sure the error message string is always in a valid
  # encoding, we'll assume UTF-8 and clean the string of anything that's not a
  # valid UTF-8 character.
  #
  # Returns a valid UTF-8 string.
  #
  # source://mysql2//lib/mysql2/error.rb#92
  def clean_message(message); end

  class << self
    # source://mysql2//lib/mysql2/error.rb#60
    def new_with_args(msg, server_version, error_number, sql_state); end
  end
end

# source://mysql2//lib/mysql2/error.rb#12
Mysql2::Error::CODES = T.let(T.unsafe(nil), Hash)

# source://mysql2//lib/mysql2/error.rb#9
class Mysql2::Error::ConnectionError < ::Mysql2::Error; end

# source://mysql2//lib/mysql2/error.rb#3
Mysql2::Error::ENCODE_OPTS = T.let(T.unsafe(nil), Hash)

# source://mysql2//lib/mysql2/error.rb#10
class Mysql2::Error::TimeoutError < ::Mysql2::Error; end

# source://mysql2//lib/mysql2/field.rb#2
class Mysql2::Field < ::Struct
  # Returns the value of attribute name
  #
  # @return [Object] the current value of name
  def name; end

  # Sets the attribute name
  #
  # @param value [Object] the value to set the attribute name to.
  # @return [Object] the newly set value
  def name=(_); end

  # Returns the value of attribute type
  #
  # @return [Object] the current value of type
  def type; end

  # Sets the attribute type
  #
  # @param value [Object] the value to set the attribute type to.
  # @return [Object] the newly set value
  def type=(_); end

  class << self
    def [](*_arg0); end
    def inspect; end
    def keyword_init?; end
    def members; end
    def new(*_arg0); end
  end
end

# source://mysql2//lib/mysql2/result.rb#2
class Mysql2::Result
  include ::Enumerable

  def count; end
  def each(*_arg0); end
  def fields; end
  def free; end

  # Returns the value of attribute server_flags.
  #
  # source://mysql2//lib/mysql2/result.rb#3
  def server_flags; end

  def size; end
end

# source://mysql2//lib/mysql2/statement.rb#2
class Mysql2::Statement
  include ::Enumerable

  def _execute(*_arg0); end
  def affected_rows; end
  def close; end

  # source://mysql2//lib/mysql2/statement.rb#5
  def execute(*args, **kwargs); end

  def field_count; end
  def fields; end
  def last_id; end
  def param_count; end
end

# source://mysql2//lib/mysql2.rb#62
module Mysql2::Util
  class << self
    # Rekey a string-keyed hash with equivalent symbols.
    #
    # source://mysql2//lib/mysql2.rb#66
    def key_hash_as_symbols(hash); end
  end
end

# source://mysql2//lib/mysql2.rb#80
Mysql2::Util::TIMEOUT_ERROR_CLASS = Timeout::Error

# source://mysql2//lib/mysql2/version.rb#2
Mysql2::VERSION = T.let(T.unsafe(nil), String)
