require 'spec_helper'

describe "Exceptions" do

  class MySpecialError < RuntimeError
  end

  it "should demonstrate exceptions_inherit_from_Exception" do
    MySpecialError.ancestors[1].should eql RuntimeError
    MySpecialError.ancestors[2].should eql StandardError
    MySpecialError.ancestors[3].should eql Exception
    MySpecialError.ancestors[4].should eql Object
  end

  it "should demonstrate rescue_clause" do
    result = nil
    begin
      fail "Oops"
    rescue StandardError => ex
      result = :exception_handled
    end

    result.should eql :exception_handled

    ex.is_a?(StandardError).should eql(true), "Should be a Standard Error"
    ex.is_a?(RuntimeError).should eql(true), "Should be a Runtime Error"

    expect(RuntimeError.ancestors.include?(StandardError)).to be_truthy, "RuntimeError is a subclass of StandardError"

    ex.message.should eql "Oops"
  end

  it "should demonstrate raising_a_particular_error" do
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, "My Message"
    rescue MySpecialError => ex
      result = :exception_handled
    end

    result.should eql :exception_handled
    ex.message.should eql "My Message"
  end

  it "should demonstrate ensure_clause" do
    result = nil
    begin
      fail "Oops"
    rescue StandardError => ex
      # no code here
    ensure
      result = :always_run
    end

    result.should eql :always_run
  end

  # Sometimes, we must know about the unknown
  it "should demonstrate asserting_an_error_is_raised" do
    # A do-end is a block, a topic to explore more later
    expect{raise MySpecialError.new("New instances can be raised directly.")}.to raise_error(MySpecialError)
  end
end