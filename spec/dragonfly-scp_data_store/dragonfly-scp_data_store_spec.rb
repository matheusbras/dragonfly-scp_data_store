require 'spec_helper'

describe Dragonfly::ScpDataStore::DataStore do
  let(:fixture_file) { File.new(File.expand_path("spec/fixtures/bike.jpg")) }

  describe "attributes" do
    let(:data_store) do
      Dragonfly::ScpDataStore::DataStore.new(
        host: "localhost",
        username: "root",
        password: "password",
        folder: "images",
        base_url: "localhost:3000/images",
      )
    end

    it { data_store.host.should eq("localhost") }
    it { data_store.username.should eq("root") }
    it { data_store.password.should eq("password") }
    it { data_store.folder.should eq("images") }
    it { data_store.base_url.should eq("localhost:3000/images") }
  end

  describe "#store" do
    let(:temp_object) { Dragonfly::TempObject.new(fixture_file) }
    let(:data_store) do
      Dragonfly::ScpDataStore::DataStore.new(
        host: "localhost",
        username: "root",
        password: "password",
        folder: "../fixtures/images",
        base_url: "localhost:3000/images",
      )
    end

    before do
      data_store.should_receive(:create_remote_folder).exactly(2).times.and_return(true)
      data_store.should_receive(:upload_file).exactly(2).times.and_return(true)
      data_store.should_receive(:chmod).exactly(2).times.and_return(true)
    end

    it "returns an uid unique uid" do
      data_store.store(temp_object).should_not eq(data_store.store(temp_object))
    end

  end

  describe "#retrieve" do
    let(:data_store) do
      Dragonfly::ScpDataStore::DataStore.new(
        host: "localhost",
        username: "root",
        password: "password",
        folder: "../fixtures/images",
        base_url: "http://localhost:3000/images",
      )
    end

    context :failure do
      it "returns an uid unique uid" do
        expect {
          data_store.retrieve('missing.jpg')
        }.to raise_error(Dragonfly::ScpDataStore::DataNotFound)
      end
    end

  end

  describe "#destroy" do
    let(:data_store) do
      Dragonfly::ScpDataStore::DataStore.new(
        host: "localhost",
        username: "root",
        password: "password",
        folder: "../fixtures/images",
        base_url: "localhost:3000/images",
      )
    end

    it "returns true" do
      data_store.destroy('any_uid').should be_true
    end

  end
end