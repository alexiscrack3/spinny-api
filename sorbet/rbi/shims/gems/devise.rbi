# typed: true
# frozen_string_literal: true

module Devise
  module Controllers
    module Helpers
      sig { returns(T.nilable(Player)) }
      def current_player; end
    end
  end
end
