module Spring
  module Commands
    class Rails
      def call
        ARGV.unshift command_name
        load Dir.glob(::Rails.root.join("{bin,script}/rails")).first
      end

      def description
        nil
      end
    end

    class RailsConsole < Rails
      def env(args)
        args.first if args.first && !args.first.index("-")
      end

      def command_name
        "console"
      end
    end

    class RailsGenerate < Rails
      def command_name
        "generate"
      end
    end

    class RailsDestroy < Rails
      def command_name
        "destroy"
      end
    end

    class RailsRunner < Rails
      def call
        ARGV.replace extract_environment(ARGV).first
        super
      end

      def env(args)
        extract_environment(args).last
      end

      def command_name
        "runner"
      end

      def extract_environment(args)
        environment = nil

        args = args.select.with_index { |arg, i|
          case arg
          when "-e"
            false
          when /--environment=(\w+)/
            environment = $1
            false
          else
            if i > 0 && args[i - 1] == "-e"
              environment = arg
              false
            else
              true
            end
          end
        }

        [args, environment]
      end
    end

    Spring.register_command "rails_console",  RailsConsole.new
    Spring.register_command "rails_generate", RailsGenerate.new
    Spring.register_command "rails_destroy",  RailsDestroy.new
    Spring.register_command "rails_runner",   RailsRunner.new
  end
end
