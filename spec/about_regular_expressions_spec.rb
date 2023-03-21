require 'spec_helper'

describe "Regular Expressions" do

  it "should demonstrate a_pattern_is_a_regular_expression" do
    /pattern/.class.should eql Regexp
  end

  it "should demonstrate a_regexp_can_search_a_string_for_matching_content" do
    "some matching content"[/match/].should eql "match"
  end

  it "should demonstrate a_failed_match_returns_nil" do
    "some matching content"[/missing/].should eql nil
  end

  # ------------------------------------------------------------------

  it "should demonstrate question_mark_means_optional" do
    "abbcccddddeeeee"[/ab?/].should eql "ab"
    "abbcccddddeeeee"[/az?/].should eql "a"
  end

  it "should demonstrate plus_means_one_or_more" do
    "abbcccddddeeeee"[/bc+/].should eql "bccc"
  end

  it "should demonstrate asterisk_means_zero_or_more" do
    "abbcccddddeeeee"[/ab*/].should eql "abb"
    "abbcccddddeeeee"[/az*/].should eql "a"
    "abbcccddddeeeee"[/z*/].should eql ""

    # THINK ABOUT IT:
    #
    # When would * fail to match?
  end

  # THINK ABOUT IT:
  #
  # We say that the repetition operators above are "greedy."
  #
  # Why?

  # ------------------------------------------------------------------

  it "should demonstrate the_left_most_match_wins" do
    "abbccc az"[/az*/].should eql "a"
  end

  # ------------------------------------------------------------------

  it "should demonstrate character_classes_give_options_for_a_character" do
    animals = ["cat", "bat", "rat", "zat"]
    animals.select { |a| a[/[cbr]at/] }.should eql ["cat", "bat", "rat"]
  end

  it "should demonstrate slash_d_is_a_shortcut_for_a_digit_character_class" do
    "the number is 42"[/[0123456789]+/].should eql "42"
    "the number is 42"[/\d+/].should eql "42"
  end

  it "should demonstrate character_classes_can_include_ranges" do
    "the number is 42"[/[0-9]+/].should eql "42"
  end

  it "should demonstrate slash_s_is_a_shortcut_for_a_whitespace_character_class" do
    "space: \t\n"[/\s+/].should eql " \t\n"
  end

  it "should demonstrate slash_w_is_a_shortcut_for_a_word_character_class" do
    # NOTE:  This is more like how a programmer might define a word.
    "variable_1 = 42"[/[a-zA-Z0-9_]+/].should eql "variable_1"
    "variable_1 = 42"[/\w+/].should eql "variable_1"
  end

  it "should demonstrate period_is_a_shortcut_for_any_non_newline_character" do
    "abc\n123"[/a.+/].should eql "abc"
  end

  it "should demonstrate a_character_class_can_be_negated" do
    "the number is 42"[/[^0-9]+/].should eql "the number is "
  end

  it "should demonstrate shortcut_character_classes_are_negated_with_capitals" do
    "the number is 42"[/\D+/].should eql "the number is "
    "space: \t\n"[/\S+/].should eql "space:"
    # ... a programmer would most likely do
    "variable_1 = 42"[/[^a-zA-Z0-9_]+/].should eql " = "
    "variable_1 = 42"[/\W+/].should eql " = "
  end

  # ------------------------------------------------------------------

  it "should demonstrate slash_a_anchors_to_the_start_of_the_string" do
    "start end"[/\Astart/].should eql "start"
    "start end"[/\Aend/].should eql nil
  end

  it "should demonstrate slash_z_anchors_to_the_end_of_the_string" do
    "start end"[/end\z/].should eql "end"
    "start end"[/start\z/].should eql nil
  end

  it "should demonstrate caret_anchors_to_the_start_of_lines" do
    "num 42\n2 lines"[/^\d+/].should eql "2"
  end

  it "should demonstrate dollar_sign_anchors_to_the_end_of_lines" do
    "2 lines\nnum 42"[/\d+$/].should eql "42"
  end

  it "should demonstrate slash_b_anchors_to_a_word_boundary" do
    "bovine vines"[/\bvine./].should eql "vines"
  end

  # ------------------------------------------------------------------

  it "should demonstrate parentheses_group_contents" do
    "ahahaha"[/(ha)+/].should eql "hahaha"
  end

  # ------------------------------------------------------------------

  it "should demonstrate parentheses_also_capture_matched_content_by_number" do
    "Gray, James"[/(\w+), (\w+)/, 1].should eql "Gray"
    "Gray, James"[/(\w+), (\w+)/, 2].should eql "James"
  end

  it "should demonstrate variables_can_also_be_used_to_access_captures" do
    "Name:  Gray, James"[/(\w+), (\w+)/].should eql "Gray, James"
    $1.should eql "Gray"
    $2.should eql "James"
  end

  # ------------------------------------------------------------------

  it "should demonstrate a_vertical_pipe_means_or" do
    grays = /(James|Dana|Summer) Gray/
    "James Gray"[grays].should eql "James Gray"
    "Summer Gray"[grays, 1].should eql "Summer"
    "Jim Gray"[grays, 1].should eql nil
  end

  # THINK ABOUT IT:
  #
  # Explain the difference between a character class ([...]) and alternation (|).

  # ------------------------------------------------------------------

  it "should demonstrate scan_is_like_find_all" do
    "one two-three".scan(/\w+/).should eql ["one", "two", "three"]
  end

  it "should demonstrate sub_is_like_find_and_replace" do
    "one two-three".sub(/(t\w*)/) { $1[0, 1] }.should eql "one t-three"
  end

  it "should demonstrate gsub_is_like_find_and_replace_all" do
    "one two-three".gsub(/(t\w*)/) { $1[0, 1] }.should eql "one t-t"
  end
end