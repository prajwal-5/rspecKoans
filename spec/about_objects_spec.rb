require 'spec_helper'

describe "Objects" do

  it "should show that everything is an object" do
    1.is_a?(Object).should == true
    1.5.is_a?(Object).should == true
    "string".is_a?(Object).should == true
    nil.is_a?(Object).should == true
    Object.is_a?(Object).should == true
  end

  it "should convert objects to strings" do
    123.to_s.should eql "123"
    nil.to_s.should eql ""
  end

  it "should be able to be inspected" do
    123.inspect.should eql "123"
    nil.inspect.should eql "nil"
  end

  it "should show that objects have ids" do
    obj = Object.new
    obj.object_id.class.should == Integer
  end

  it "should create objects with different ids" do
    obj = Object.new
    another_obj = Object.new
    (obj.object_id != another_obj.object_id).should == true
  end

  it "should have the same object id for some system objects" do
    false.object_id.should == 0
    true.object_id.should == 20
    nil.object_id.should == 8
  end

  it "should have fixed ids for small integers" do
    0.object_id.should == 1
    1.object_id.should == 3
    2.object_id.should == 5
    100.object_id.should == 201

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow?
  end

  it "should clone objects to create a different object" do
    obj = Object.new
    copy = obj.clone

    (obj != copy).should == true
    (obj.object_id != copy.object_id).should == true
  end
end