require 'nerve/service_watcher/base'

module Nerve
  module ServiceCheck
    class FileServiceCheck < BaseServiceCheck
      
      def initialize(opts={})
        super

        raise ArgumentError, "missing required argument 'backup' in file check" unless opts['backup']
      
        @backup_file = opts['backup']
      end

      def check
        log.debug "nerve: running file existence check #{@name}" 

        if File.exist?(@backup_file)
          log.debug("#{@backup_file} config file exists")
        else
          #log.error("#{@backup_file} config file not exists")
          raise IOError, "missing required backup config file"
        end
      end
    end

    CHECKS ||= {}
    CHECKS['file'] = FileServiceCheck
  end
end
