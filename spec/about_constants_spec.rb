require 'spec_helper'

C = "top level"

describe "Constants" do
  class AboutConstants
    C = "nested"
  end

  it "should demonstrate nested_constants_may_also_be_referenced_with_relative_paths" do
    C.should eql "top level"
  end

  it "should demonstrate top_level_constants_are_referenced_by_double_colons" do
    ::C.should eql "top level"
  end

  it "should demonstrate nested_constants_are_referenced_by_their_complete_path" do
    AboutConstants::C.should eql ("nested")
    ::AboutConstants::C.should eql ("nested")
  end

  # ------------------------------------------------------------------

  class Animal
    LEGS = 4
    def legs_in_animal
      LEGS
    end

    class NestedAnimal
      def legs_in_nested_animal
        LEGS
      end
    end
  end

  it "should demonstrate nested_classes_inherit_constants_from_enclosing_classes" do
    Animal::NestedAnimal.new.legs_in_nested_animal.should eql 4
  end

  # ------------------------------------------------------------------

  class Reptile < Animal
    def legs_in_reptile
      LEGS
    end
  end

  it "should demonstrate subclasses_inherit_constants_from_parent_classes" do
    Reptile.new.legs_in_reptile.should eql 4
  end

  # ------------------------------------------------------------------

  class MyAnimals
    LEGS = 2

    class Bird < Animal
      def legs_in_bird
        LEGS
      end
    end
  end

  it "should demonstrate who_wins_with_both_nested_and_inherited_constants" do
    MyAnimals::Bird.new.legs_in_bird.should eql 2
  end

  # QUESTION: Which has precedence: The constant in the lexical scope,
  # or the constant from the inheritance hierarchy?

  # ------------------------------------------------------------------

  class MyAnimals::Oyster < Animal
    def legs_in_oyster
      LEGS
    end
  end

  it "should demonstrate who_wins_with_explicit_scoping_on_class_definition" do
    MyAnimals::Oyster.new.legs_in_oyster.should eql 4
  end

  # QUESTION: Now which has precedence: The constant in the lexical
  # scope, or the constant from the inheritance hierarchy?  Why is it
  # different than the previous answer?
end