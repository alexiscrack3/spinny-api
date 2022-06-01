# frozen_string_literal: true

class WelcomeJob < ApplicationJob
  queue_as :default

  before_enqueue :print_before_enqueue
  after_enqueue :print_after_enqueue

  before_perform :print_before_perform
  after_perform :print_after_perform

  def print_before_enqueue
    puts "Printing from inside before_enqueue callback"
  end

  def print_after_enqueue
    puts "Printing from inside after_enqueue callback"
  end

  def print_before_perform
    puts "Printing from inside before_perform callback"
  end

  def print_after_perform
    puts "Printing from inside after_perform callback"
  end

  def perform(*args)
    # Do something later
    puts "Sending welcome email"
  end
end
