require 'spec_helper'

describe "Arrays" do

  it 'should demonstrate array creation' do
    empty_array = Array.new
    empty_array.class.should eql Array
    empty_array.size.should eql 0
  end

  it "should demonstrate array literals" do
    array = Array.new
    array.should eql []

    array[0] = 1
    array.should eql [1]

    array[1] = 2
    array.should eql [1, 2]

    array << 333
    array.should eql [1, 2, 333]
  end

  it "should demonstrate accessing array elements" do
    array = [:peanut, :butter, :and, :jelly]

    array[0].should eql :peanut
    array.first.should eql :peanut
    array[3].should eql :jelly
    array.last.should eql :jelly
    array[-1].should eql :jelly
    array[-3].should eql :butter
  end

  it "should demonstrate slicing arrays" do
    array = [:peanut, :butter, :and, :jelly]

    array[0,1].should eql [:peanut]
    array[0,2].should eql [:peanut, :butter]
    array[2,2].should eql [:and, :jelly]
    array[2,20].should eql [:and, :jelly]
    array[4,0].should eql []
    array[4,100].should eql []
    array[5,0].should eql nil
  end

  it "should show arrays and ranges" do
    array = [:peanut, :butter, :and, :jelly]

    (1..5).class.should eql Range
    (1..5).should_not eql [1,2,3,4,5]
    (1..5).to_a.should eql [1,2,3,4,5]
    (1...5).to_a.should eql [1,2,3,4]
  end

  it "should demonstrate slicing with ranges" do
    array = [:peanut, :butter, :and, :jelly]

    array[0..2].should eql [:peanut, :butter, :and]
    array[0...2].should eql [:peanut, :butter]
    array[2..-1].should eql [:and, :jelly]
  end

  it "should demonstrate pushing and popping arrays" do
    array = [1,2]
    array.push(:last)

    array.should eql [1,2,:last]

    popped_value = array.pop
    popped_value.should eql :last
    array.should eql [1,2]
  end

  it "should demonstrate shifting arrays" do
    array = [1,2]
    array.unshift(:first)

    array.should eql [:first, 1, 2]

    shifted_value = array.shift
    shifted_value.should eql :first
    array.should eql [1,2]
  end
end