require 'spec_helper'

describe "Array Assignment" do

  it 'should demonstrate non-parallel assignment' do
    names = ["John", "Smith"]
    names.should eql ["John", "Smith"]
  end

  it 'should demonstrate parallel assignment' do
    first_name, last_name = ["John", "Smith"]
    first_name.should eql "John"
    last_name.should eql "Smith"
  end

  it 'should demonstrate parallel assignments with splat operator' do
    first_name, *last_name = ["John", "Smith", "III"]
    first_name.should eql "John"
    last_name.should eql ["Smith", "III"]
  end

  it 'should demonstrate parallel assignments with too few variables' do
    first_name, last_name = ["Cher"]
    first_name.should eql "Cher"
    last_name.should eql nil
  end

  it 'should demonstrate parallel assignments with subarrays' do
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    first_name.should eql ["Willie", "Rae"]
    last_name.should eql "Johnson"
  end

  it 'should demonstrate parallel assignments with one variable' do
    first_name, = ["John", "Smith"]
    first_name.should eql "John"
  end

  it 'should demonstrate swapping with parallel assignment' do
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    first_name.should eql "Rob"
    last_name.should eql "Roy"
  end
end