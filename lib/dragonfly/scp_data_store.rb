require "dragonfly/scp_data_store/version"
require 'dragonfly'
require 'net/http'
require 'net/ssh'
require 'net/scp'

module Dragonfly
  module ScpDataStore
    class DataNotFound < RuntimeError; end

    class DataStore
      include ::Dragonfly::Configurable

      configurable_attr :host
      configurable_attr :username
      configurable_attr :password
      configurable_attr :folder
      configurable_attr :base_url

      def initialize(options = {})
        self.host = options[:host]
        self.username = options[:username]
        self.password = options[:password]
        self.folder = options[:folder]
        self.base_url = options[:base_url]
      end

      def store(temp_object, opts={})
        uid = generate_uid(temp_object.name || 'file')

        process_file(temp_object.file.path, uid)

        uid
      end

      def retrieve(uid)
        uri = URI(base_url + uid)
        response = Net::HTTP.get_response(uri)

        if response.is_a? Net::HTTPSuccess
          [response.body, { }]
        else
          raise DataNotFound
        end
      end

      def destroy(uid)
        true
      end

      private
        def generate_uid(file)
          name = File.basename(file, '.*').parameterize
          extension = File.extname(file).downcase

          time = Time.now.strftime '%Y/%m/%d/%H/%M'
          hash = SecureRandom.hex(5)

          "#{time}/#{hash}/#{name}#{extension}"
        end

        def process_file(file, uid)
          remote_file = folder + uid
          remote_folder = File.dirname(remote_file)

          create_remote_folder(remote_folder)
          upload_file(file, remote_file)
          chmod(remote_file)
        end

        def create_remote_folder(folder)
          exec("mkdir -m 777 -p #{folder}")
        end

        def chmod(file, mode = 755)
          exec("chmod #{mode} #{file}")
        end

        def upload_file(path, remote_path)
          Net::SCP.start(host, username, password: password) do |scp|
            scp.upload!(path, remote_path)
          end
        end

        def exec(command)
          Net::SSH.start(host, username, password: password) do |ssh|
            ssh.exec!(command)
          end
        end
      end
  end
end