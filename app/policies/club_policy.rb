# typed: true
# frozen_string_literal: true

class ClubPolicy < ApplicationPolicy
  sig { returns(T::Boolean) }
  def index?
    user.admin?
  end
end
