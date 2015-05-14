require 'spec_helper'
require 'pry'

describe RubySpark::Core do

  context "when things go right" do
    before  { RubySpark.access_token = "good_access_token" }
    subject { described_class.new("good_core_id") }

    describe "#info" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("info") do
          info = subject.info

          info.should be_a Hash
          info.keys.should =~ ["id", "name", "variables", "functions"]
        end
      end
    end

    describe "#variable" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("variable") do
          subject.variable("temperature").should == 70
        end
      end
    end

    describe "#function" do
      it "succeeds when Access Token and Core ID are correct" do
        VCR.use_cassette("function") do
          subject.function("readTemp", "outside").should == 72
        end
      end
    end
  end

  context "when things go wrong" do
    it "returns the appropriate error when Access Token is bad" do
      RubySpark.access_token = "bad_token"
      subject = described_class.new("good_core_id")

      VCR.use_cassette("bad_token") do
        expect {
          subject.info
        }.to raise_error(RubySpark::Core::ApiError)
      end

      VCR.use_cassette("bad_token") do
        begin
          subject.info
        rescue => e
          e.message.should == "invalid_grant: The access token provided is invalid."
        end
      end
    end

    it "returns proper error if Access Token is not defined" do
      RubySpark.access_token = nil

      expect {
        subject = described_class.new("good_core_id")
      }.to raise_error(RubySpark::ConfigurationError)
    end

    it "returns the appropriate error when Core ID is bad" do
      RubySpark.access_token = "good_access_token"
      subject = described_class.new("bad_core_id")

      VCR.use_cassette("bad_core_id") do
        expect {
          subject.info
        }.to raise_error(RubySpark::Core::ApiError)
      end

      VCR.use_cassette("bad_core_id") do
        begin
          subject.info
        rescue => e
          e.message.should == "Permission Denied: Invalid Core ID"
        end
      end
    end

    it "returns the appropriate error when the Particle API times out" do
      RubySpark.access_token = "good_access_token"
      subject = described_class.new("good_core_id")

      VCR.use_cassette("spark_timeout") do
        expect {
          subject.info
        }.to raise_error(RubySpark::Core::ApiError)
      end

      VCR.use_cassette("spark_timeout") do
        begin
          subject.info
        rescue => e
          e.message.should == "Timed out."
        end
      end
    end
  end

end
