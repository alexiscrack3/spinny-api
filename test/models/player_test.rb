require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player =
      Player.new(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email
      )
  end

  test 'player should be valid' do
    assert @player.valid?
  end

  test 'player should not valid when first name is nil' do
    @player.first_name = nil
    assert_not @player.valid?
  end

  test 'player should not valid when last name is nil' do
    @player.last_name = nil
    assert_not @player.valid?
  end

  test 'player should not be valid when email is nil' do
    @player.email = '   '
    assert_not @player.valid?
  end

  test 'player should not valid when first name is empty' do
    @player.first_name = ''
    assert_not @player.valid?
  end

  test 'player should not valid when last name is empty' do
    @player.last_name = ''
    assert_not @player.valid?
  end

  test 'player should not be valid when email is empty' do
    @player.email = ''
    assert_not @player.valid?
  end

  test 'player should not valid when first name is blank' do
    @player.first_name = ' '
    assert_not @player.valid?
  end

  test 'player should not valid when last name is blank' do
    @player.last_name = ' '
    assert_not @player.valid?
  end

  test 'player should not be valid when email is blank' do
    @player.email = '   '
    assert_not @player.valid?
  end

  test 'player should not be valid when email is too long' do
    @player.email = "#{'a' * 244}@example.com"
    assert_not @player.valid?
  end

  test 'player should be valid when email is valid' do
    valid_addresses = %w[
      user@example.com
      USER@foo.com
      A_US-ER@foo.bar.org
      first.last@foo.jp
      alice+bob@baz.cn
    ]
    valid_addresses.each do |valid_address|
      @player.email = valid_address
      assert @player.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'player should not be valid when email is invalid' do
    invalid_addresses = %w[
      user@example
      user_at_foo.org
      user.name@example.
      foo@bar_baz.com
      foo@bar+baz.com
    ]
    invalid_addresses.each do |invalid_address|
      @player.email = invalid_address
      assert_not @player.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'player should be saved with email as lowercase' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @player.email = mixed_case_email
    @player.save
    assert_equal mixed_case_email.downcase, @player.reload.email
  end

  test 'player should not be valid when email is not unique' do
    duplicate_player = @player.dup
    duplicate_player.email = @player.email.upcase
    @player.save
    assert_not duplicate_player.valid?
  end
end
