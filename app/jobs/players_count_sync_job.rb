# frozen_string_literal: true

class PlayersCountSyncJob
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    clubs = Club.all
    clubs.each do |club|
      count = Membership.where(club_id: club.id).count
      club.update(players_count: count)
    end
  end
end
