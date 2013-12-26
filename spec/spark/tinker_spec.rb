require 'spec_helper'
require 'pry'

describe Spark::Tinker do

  context "with Access Token set in config variable" do
    before  { Spark.access_token = "good_access_token" }
    subject { described_class.new("good_core_id") }

    describe "#digital_write" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("digital_write") do
          subject.digital_write(7, "HIGH").should == true
        end
      end

      it "returns the appropriate error when Access Token is bad" do
        Spark.access_token = "bad_token"

        VCR.use_cassette("bad_token") do
          expect {
            subject.digital_write(7, "HIGH")
          }.to raise_error(Spark::Core::ApiError)
        end

        VCR.use_cassette("bad_token") do
          begin
            subject.digital_write(7, "HIGH")
          rescue => e
            e.message.should == "invalid_grant: The access token provided is invalid."
          end
        end
      end

      it "returns the appropriate error when Core ID is bad" do
        subject = described_class.new("bad_core_id")

        VCR.use_cassette("bad_core_id") do
          expect {
            subject.digital_write(7, "HIGH")
          }.to raise_error(Spark::Core::ApiError)
        end

        VCR.use_cassette("bad_core_id") do
          begin
            subject.digital_write(7, "HIGH")
          rescue => e
            e.message.should == "Permission Denied: Invalid Core ID"
          end
        end
      end

      it "returns the appropriate error when the Spark API times out" do
        VCR.use_cassette("spark_timeout") do
          expect {
            subject.digital_write(7, "HIGH")
          }.to raise_error(Spark::Core::ApiError)
        end

        VCR.use_cassette("spark_timeout") do
          begin
            subject.digital_write(7, "HIGH")
          rescue => e
            e.message.should == "Timed out."
          end
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

  context "with Access Token passed into Core" do
    subject { described_class.new("good_core_id", "good_access_token") }

    describe "#digital_read" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("digital_write") do
          subject.digital_write(7, "HIGH").should == true
        end
      end
    end
  end

  context "with no Access Token defined" do
    before  { Spark.access_token = nil }
    subject { described_class.new("good_core_id") }

    it "returns proper error if Access Token is not defined" do
      VCR.use_cassette("no_token") do
        expect {
          subject.digital_read(6)
        }.to raise_error(Spark::ConfigurationError)
      end

      VCR.use_cassette("no_token") do
        begin
          subject.digital_read(6)
        rescue => e
          e.message.should == "Access Token not defined"
        end
      end
    end
  end
end
