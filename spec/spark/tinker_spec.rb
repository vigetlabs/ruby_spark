require 'spec_helper'
require 'pry'

describe RubySpark::Tinker do

  context "with Access Token set in config variable" do
    before  { RubySpark.access_token = "good_access_token" }
    subject { described_class.new("good_core_id") }

    describe "#digital_write" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("digital_write") do
          subject.digital_write(7, "HIGH").should == true
        end
      end
    end

    describe "#digital_read" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("digital_read") do
          subject.digital_read(6).should == "HIGH"
        end
      end
    end

    describe "#analog_write" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("analog_write") do
          subject.analog_write(7, 130).should == true
        end
      end
    end

    describe "#analog_read" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("analog_read") do
          subject.analog_read(6).should == 2399
        end
      end
    end
  end
end
