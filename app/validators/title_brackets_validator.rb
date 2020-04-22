# frozen_string_literal: true

class TitleBracketsValidator < ActiveModel::Validator
  attr_accessor :title
  attr_reader :record
  BRACKET_TYPES = %w([] {} ())

  def validate(record)
    @record = record
    @title = record.title
    select_brackets
  end

  private

  def title_invalid?
    BRACKET_TYPES.any? { |empty_bracket| title.include?(empty_bracket) }
  end

  def select_brackets
    return error_message if title_invalid?

    brackets = title.gsub(/[a-z A-Z 0-9]/, '')
    check_brackets_order(brackets)
  end

  def check_brackets_order(brackets)
    return true if brackets.length == 0

    if brackets.include?('[]')
      brackets = brackets.gsub!('[]', '')
      check_brackets_order(brackets)
    elsif brackets.include?('{}')
      brackets = brackets.gsub!('{}', '')
      check_brackets_order(brackets)
    elsif brackets.include?('()')
      brackets = brackets.gsub!('()', '')
      check_brackets_order(brackets)
    else
      return error_message
    end
  end

  def error_message
    record.errors.add(title, "Brackets can't be empty.")
  end
end
