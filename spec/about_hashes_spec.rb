require 'spec_helper'

describe "Hashes" do

  it "should demonstrate creating hashes" do
    empty_hash = Hash.new
    empty_hash.class.should eql Hash
    empty_hash.should == {}
    empty_hash.size.should eql 0
  end

  it "should demonstrate hash literals" do
    hash = { :one => "uno", :two => "dos" }
    hash.size.should eql 2
  end

  it "should demonstrate accessing hashes" do
    hash = { :one => "uno", :two => "dos" }
    hash[:one].should eql "uno"
    hash[:two].should eql "dos"
    hash[:doesnt_exist].should eql nil
  end

  it "should demonstrate accessing hashes with fetch" do
    hash = { :one => "uno" }
    hash.fetch(:one).should eql "uno"
    expect{ hash.fetch(:doesnt_exist) }.to raise_error(KeyError)

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
  end

  it "should demonstrate changing hashes" do
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => "uno", :two => "dos" }
    (expected == hash).should eql false

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
  end

  it "should demonstrate that a hash is unordered" do
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    (hash1 == hash2).should eql true
  end

  it "should demonstrate hash keys" do
    hash = { :one => "uno", :two => "dos" }
    hash.keys.size.should eql 2
    hash.keys.include?(:one).should eql true
    hash.keys.include?(:two).should eql true
    hash.keys.class.should eql Array
  end

  it "should demonstrate hash values" do
    hash = { :one => "uno", :two => "dos" }
    hash.values.size.should eql 2
    hash.values.include?("uno").should eql true
    hash.values.include?("dos").should eql true
    hash.values.class.should eql Array
  end

  it "should demonstrate combining hashes" do
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    (hash != new_hash).should eql true

    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    (expected == new_hash).should eql true
  end

  it "should demonstrate default values" do
    hash1 = Hash.new
    hash1[:one] = 1

    hash1[:one].should eql 1
    hash1[:two].should eql nil

    hash2 = Hash.new("dos")
    hash2[:one] = 1

    hash2[:one].should eql 1
    hash2[:two].should eql "dos"
  end

  it "should demonstrate that the default value is the same object" do
    hash = Hash.new([])

    hash[:one] << "uno"
    hash[:two] << "dos"

    hash[:one].should eql ["uno", "dos"]
    hash[:two].should eql ["uno", "dos"]
    hash[:three].should eql ["uno", "dos"]

    (hash[:one].object_id == hash[:two].object_id).should eql true
  end

  it "should demonstrate default value with a block" do
    hash = Hash.new {|hash, key| hash[key] = [] }

    hash[:one] << "uno"
    hash[:two] << "dos"

    hash[:one].should eql ["uno"]
    hash[:two].should eql ["dos"]
    hash[:three].should eql []
  end
end