require 'spec_helper'

describe "Scope" do

  module AboutScope
    PI = 3.1416
    MyString = "HI"
  end

  module Jims
    class Doggy5
      def identify
        :jims_dog
      end
    end
  end

  module Joes
    class Doggy5
      def identify
        :joes_dog
      end
    end
  end

  it "should demonstrate dog_is_not_available_in_the_current_scope" do
    expect{fido = Doggy5.new}.to raise_error(NameError)
  end

  it "should demonstrate you_can_reference_nested_classes_using_the_scope_operator" do
    fido = Jims::Doggy5.new
    rover = Joes::Doggy5.new
    fido.identify.should eql :jims_dog
    rover.identify.should eql :joes_dog

    (fido.class != rover.class).should eql true
    (Jims::Doggy5 != Joes::Doggy5).should eql true
  end

  # ------------------------------------------------------------------

  class String
  end

  # it "should demonstrate bare_bones_class_names_assume_the_current_scope" do
  #   (AboutScope::String == String).should eql __
  # end

  it "should demonstrate nested_string_is_not_the_same_as_the_system_string" do
    (String == "HI".class).should eql true
  end

  it "should demonstrate use_the_prefix_scope_operator_to_force_the_global_scope" do
    (::String == "HI".class).should eql true
  end

  # ------------------------------------------------------------------

  PI = 3.1416

  it "should demonstrate constants_are_defined_with_an_initial_uppercase_letter" do
    PI.should eql 3.1416
  end

  # ------------------------------------------------------------------

  MyString = ::String

  it "should demonstrate class_names_are_just_constants" do
    (MyString == ::String).should eql true
    (MyString == "HI".class).should eql true
  end

  it "should demonstrate constants_can_be_looked_up_explicitly" do
    (PI == AboutScope.const_get("PI")).should eql true
    (MyString == AboutScope.const_get("MyString")).should eql false
  end

  it "should demonstrate you_can_get_a_list_of_constants_for_any_class_or_module" do
    Jims.constants.should eql [:Doggy5]
    (Object.constants.size).should > 100
  end
end