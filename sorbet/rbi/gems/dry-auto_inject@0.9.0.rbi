# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `dry-auto_inject` gem.
# Please instead update this file by running `bin/tapioca gem dry-auto_inject`.

# source://dry-auto_inject//lib/dry/auto_inject/strategies.rb#5
module Dry
  class << self
    # Configure an auto-injection module
    #
    # @api public
    # @example
    #   module MyApp
    #   # set up your container
    #   container = Dry::Container.new
    #
    #   container.register(:data_store, -> { DataStore.new })
    #   container.register(:user_repository, -> { container[:data_store][:users] })
    #   container.register(:persist_user, -> { PersistUser.new })
    #
    #   # set up your auto-injection function
    #   AutoInject = Dry::AutoInject(container)
    #
    #   # define your injection function
    #   def self.Inject(*keys)
    #   AutoInject[*keys]
    #   end
    #   end
    #
    #   # then simply include it in your class providing which dependencies should be
    #   # injected automatically from the configured container
    #   class PersistUser
    #   include MyApp::Inject(:user_repository)
    #
    #   def call(user)
    #   user_repository << user
    #   end
    #   end
    #
    #   persist_user = container[:persist_user]
    #
    #   persist_user.call(name: 'Jane')
    # @return [Proc] calling the returned proc builds an auto-injection module
    #
    # source://dry-auto_inject//lib/dry/auto_inject.rb#43
    def AutoInject(container, options = T.unsafe(nil)); end

    # source://dry-configurable/0.16.1/lib/dry/configurable.rb#11
    def Configurable(**options); end

    # source://dry-core/0.9.1/lib/dry/core/equalizer.rb#152
    def Equalizer(*keys, **options); end
  end
end

# source://dry-auto_inject//lib/dry/auto_inject/strategies.rb#6
module Dry::AutoInject; end

# source://dry-auto_inject//lib/dry/auto_inject/builder.rb#8
class Dry::AutoInject::Builder
  # @return [Builder] a new instance of Builder
  #
  # source://dry-auto_inject//lib/dry/auto_inject/builder.rb#18
  def initialize(container, options = T.unsafe(nil)); end

  # @api public
  #
  # source://dry-auto_inject//lib/dry/auto_inject/builder.rb#24
  def [](*dependency_names); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/builder.rb#10
  def container; end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/builder.rb#13
  def strategies; end

  private

  # source://dry-auto_inject//lib/dry/auto_inject/builder.rb#34
  def method_missing(name, *args, &block); end

  # @return [Boolean]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/builder.rb#28
  def respond_to_missing?(name, _include_private = T.unsafe(nil)); end
end

# source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#10
class Dry::AutoInject::DependencyMap
  # @return [DependencyMap] a new instance of DependencyMap
  #
  # source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#11
  def initialize(*dependencies); end

  # source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#27
  def inspect; end

  # source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#31
  def names; end

  # source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#35
  def to_h; end

  # source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#35
  def to_hash; end

  private

  # @raise [DuplicateDependencyError]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#52
  def add_dependency(name, identifier); end

  # source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#42
  def name_for(identifier); end
end

# source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#6
class Dry::AutoInject::DependencyNameInvalid < ::StandardError; end

# source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#5
class Dry::AutoInject::DuplicateDependencyError < ::StandardError; end

# source://dry-auto_inject//lib/dry/auto_inject/injector.rb#8
class Dry::AutoInject::Injector < ::BasicObject
  # @api private
  # @return [Injector] a new instance of Injector
  #
  # source://dry-auto_inject//lib/dry/auto_inject/injector.rb#20
  def initialize(container, strategy, builder:); end

  # source://dry-auto_inject//lib/dry/auto_inject/injector.rb#26
  def [](*dependency_names); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/injector.rb#15
  def builder; end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/injector.rb#9
  def container; end

  def respond_to?(*_arg0); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/injector.rb#12
  def strategy; end

  private

  # source://dry-auto_inject//lib/dry/auto_inject/injector.rb#36
  def method_missing(name, *_args); end

  # @return [Boolean]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/injector.rb#30
  def respond_to_missing?(name, _include_private = T.unsafe(nil)); end
end

# @api private
#
# source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#8
class Dry::AutoInject::MethodParameters
  # @api private
  # @return [MethodParameters] a new instance of MethodParameters
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#29
  def initialize(parameters); end

  # @api private
  # @return [Boolean]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#57
  def empty?; end

  # @api private
  # @return [Boolean]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#53
  def keyword?(name); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#47
  def keyword_names; end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#61
  def length; end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#27
  def parameters; end

  # @api private
  # @return [Boolean]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#65
  def pass_through?; end

  # @api private
  # @return [Boolean]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#39
  def sequential_arguments?; end

  # @api private
  # @return [Boolean]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#33
  def splat?; end

  class << self
    # @api private
    #
    # source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#11
    def of(obj, name); end
  end
end

# @api private
#
# source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#69
Dry::AutoInject::MethodParameters::EMPTY = T.let(T.unsafe(nil), Dry::AutoInject::MethodParameters)

# @api private
#
# source://dry-auto_inject//lib/dry/auto_inject/method_parameters.rb#9
Dry::AutoInject::MethodParameters::PASS_THROUGH = T.let(T.unsafe(nil), Array)

# source://dry-auto_inject//lib/dry/auto_inject/strategies.rb#7
class Dry::AutoInject::Strategies
  extend ::Dry::Container::Mixin
  extend ::Dry::Container::Configuration
  extend ::Dry::Core::Constants
  extend ::Dry::Configurable
  extend ::Dry::Configurable::Methods
  extend ::Dry::Configurable::ClassMethods

  class << self
    # @api public
    #
    # source://dry-auto_inject//lib/dry/auto_inject/strategies.rb#11
    def register_default(name, strategy); end
  end
end

# @api private
#
# source://dry-auto_inject//lib/dry/auto_inject/strategies/args.rb#10
class Dry::AutoInject::Strategies::Args < ::Dry::AutoInject::Strategies::Constructor
  private

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/args.rb#25
  def define_initialize(klass); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/args.rb#38
  def define_initialize_with_params; end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/args.rb#51
  def define_initialize_with_splat(super_parameters); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/args.rb#13
  def define_new; end
end

# source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#8
class Dry::AutoInject::Strategies::Constructor < ::Module
  # @return [Constructor] a new instance of Constructor
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#17
  def initialize(container, *dependency_names); end

  # Returns the value of attribute class_mod.
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#15
  def class_mod; end

  # Returns the value of attribute container.
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#12
  def container; end

  # Returns the value of attribute dependency_map.
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#13
  def dependency_map; end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#26
  def included(klass); end

  # Returns the value of attribute instance_mod.
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#14
  def instance_mod; end

  private

  # @raise [NotImplementedError]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#52
  def define_initialize(_klass); end

  # @raise [NotImplementedError]
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#48
  def define_new; end

  # source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#40
  def define_readers; end
end

# source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#9
class Dry::AutoInject::Strategies::Constructor::ClassMethods < ::Module; end

# source://dry-auto_inject//lib/dry/auto_inject/strategies/constructor.rb#10
class Dry::AutoInject::Strategies::Constructor::InstanceMethods < ::Module; end

# @api private
#
# source://dry-auto_inject//lib/dry/auto_inject/strategies/hash.rb#10
class Dry::AutoInject::Strategies::Hash < ::Dry::AutoInject::Strategies::Constructor
  private

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/hash.rb#25
  def define_initialize(klass); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/hash.rb#13
  def define_new; end
end

# @api private
#
# source://dry-auto_inject//lib/dry/auto_inject/strategies/kwargs.rb#10
class Dry::AutoInject::Strategies::Kwargs < ::Dry::AutoInject::Strategies::Constructor
  private

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/kwargs.rb#85
  def assign_dependencies(kwargs, destination); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/kwargs.rb#27
  def define_initialize(klass); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/kwargs.rb#43
  def define_initialize_with_keywords(super_parameters); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/kwargs.rb#62
  def define_initialize_with_splat(super_parameters); end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/kwargs.rb#13
  def define_new; end

  # @api private
  #
  # source://dry-auto_inject//lib/dry/auto_inject/strategies/kwargs.rb#96
  def slice_kwargs(kwargs, super_parameters); end
end

# source://dry-auto_inject//lib/dry/auto_inject/dependency_map.rb#8
Dry::AutoInject::VALID_NAME = T.let(T.unsafe(nil), Regexp)
