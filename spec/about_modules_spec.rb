require 'spec_helper'

describe "Modules" do

  module Nameable
    def set_name(new_name)
      @name = new_name
    end

    def here
      :in_module
    end
  end

  it "should demonstrate cant_instantiate_modules" do
    expect{Nameable.new}.to raise_error(NoMethodError)
  end

  # ------------------------------------------------------------------

  class Dog
    include Nameable

    attr_reader :name

    def initialize
      @name = "Fido"
    end

    def bark
      "WOOF"
    end

    def here
      :in_object
    end
  end

  it "should demonstrate normal_methods_are_available_in_the_object" do
    fido = Dog.new
    fido.bark.should eql "WOOF"
  end

  it "should demonstrate module_methods_are_also_available_in_the_object" do
    fido = Dog.new
    expect{fido.set_name("Rover")}.not_to raise_error()
  end

  it "should demonstrate module_methods_can_affect_instance_variables_in_the_object" do
    fido = Dog.new
    fido.name.should eql "Fido"
    fido.set_name("Rover")
    fido.name.should eql "Rover"
  end

  it "should demonstrate classes_can_override_module_methods" do
    fido = Dog.new
    fido.here.should eql :in_object
  end
end