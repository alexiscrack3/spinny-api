require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player =
      Player.new(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
  end

  test 'user should be valid' do
    assert @player.valid?
  end

  test 'user should not valid when first name is nil' do
    @player.first_name = nil
    assert_not @player.valid?
  end

  test 'user should not valid when last name is nil' do
    @player.last_name = nil
    assert_not @player.valid?
  end

  test 'user should not valid when first name is empty' do
    @player.first_name = ''
    assert_not @player.valid?
  end

  test 'user should not valid when last name is empty' do
    @player.last_name = ''
    assert_not @player.valid?
  end

  test 'user should not valid when first name is blank' do
    @player.first_name = ' '
    assert_not @player.valid?
  end

  test 'user should not valid when last name is blank' do
    @player.last_name = ' '
    assert_not @player.valid?
  end
end
