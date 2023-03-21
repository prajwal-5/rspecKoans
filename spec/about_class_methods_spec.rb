require 'spec_helper'

describe "Class Methods" do

  class Doggy2
  end

  it "should demonstrate objects_are_objects" do
    fido = Doggy2.new
    fido.is_a?(Object).should eql true
  end

  it "should demonstrate classes_are_classes" do
    Doggy2.is_a?(Class).should eql true
  end

  it "should demonstrate classes_are_objects_too" do
    Doggy2.is_a?(Object).should eql true
  end

  it "should demonstrate objects_have_methods" do
    fido = Doggy2.new
    expect(fido.methods.size).to be > 0
  end

  it "should demonstrate classes_have_methods" do
    expect(Doggy2.methods.size).to be > 0
  end

  it "should demonstrate you_can_define_methods_on_individual_objects" do
    fido = Doggy2.new

    def fido.wag
      :fidos_wag
    end

    fido.wag.should eql :fidos_wag
  end

  it "should demonstrate other_objects_are_not_affected_by_these_singleton_methods" do
    fido = Doggy2.new
    rover = Doggy2.new

    def fido.wag
      :fidos_wag
    end

    expect{rover.wag}.to raise_error(NoMethodError)
  end

  # ------------------------------------------------------------------

  class Dog2
    def wag
      :instance_level_wag
    end
  end

  def Dog2.wag
    :class_level_wag
  end

  it "should demonstrate since_classes_are_objects_you_can_define_singleton_methods_on_them_too" do
    Dog2.wag.should eql :class_level_wag
  end

  it "should demonstrate class_methods_are_independent_of_instance_methods" do
    fido = Dog2.new
    fido.wag.should eql :instance_level_wag
    Dog2.wag.should eql :class_level_wag
  end

  # ------------------------------------------------------------------

  class Doggy2
    attr_accessor :name
  end

  def Doggy2.name
    @name
  end

  it "should demonstrate classes_and_instances_do_not_share_instance_variables" do
    fido = Doggy2.new
    fido.name = "Fido"
    fido.name.should eql "Fido"
    Doggy2.name.should eql nil
  end

  # ------------------------------------------------------------------

  class Doggy2
    def Doggy2.a_class_method
      :dogs_class_method
    end
  end

  it "should demonstrate you_can_define_class_methods_inside_the_class" do
    Doggy2.a_class_method.should eql :dogs_class_method
  end


  # ------------------------------------------------------------------

  LastExpressionInClassStatement = class Doggy2
    21
  end

  it "should demonstrate class_statements_return_the_value_of_their_last_expression" do
    LastExpressionInClassStatement.should eql 21
  end

  # ------------------------------------------------------------------

  SelfInsideOfClassStatement = class Doggy2
    self
  end

  it "should demonstrate self_while_inside_class_is_class_object_not_instance" do
    (Doggy2 == SelfInsideOfClassStatement).should eql true
  end

  # ------------------------------------------------------------------

  class Doggy2
    def self.class_method2
      :another_way_to_write_class_methods
    end
  end

  it "should demonstrate you_can_use_self_instead_of_an_explicit_reference_to_dog" do
    Doggy2.class_method2.should eql :another_way_to_write_class_methods
  end

  # ------------------------------------------------------------------

  class Doggy2
    class << self
      def another_class_method
        :still_another_way
      end
    end
  end

  it "should demonstrate heres_still_another_way_to_write_class_methods" do
    Doggy2.another_class_method.should eql :still_another_way
  end

  # THINK ABOUT IT:
  #
  # The two major ways to write class methods are:
  #   class Demo
  #     def self.method
  #     end
  #
  #     class << self
  #       def class_methods
  #       end
  #     end
  #   end
  #
  # Which do you prefer and why?
  # Are there times you might prefer one over the other?

  # ------------------------------------------------------------------

  it "should demonstrate heres_an_easy_way_to_call_class_methods_from_instance_methods" do
    fido = Doggy2.new
    fido.class.another_class_method.should eql :still_another_way
  end
end