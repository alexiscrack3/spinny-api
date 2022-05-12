# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    resolve_method(:base_resolve)

    def base_resolve(**args)
      return resolve if args.empty? # prevent typecheck no of arguments failures

      resolve(**args)
    end
  end
end
