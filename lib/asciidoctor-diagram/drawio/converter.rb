require_relative '../diagram_converter'
require_relative '../util/cli_generator'
require_relative '../util/platform'

module Asciidoctor
  module Diagram
    # @private
    class DrawioConverter
      include DiagramConverter
      include CliGenerator

      OPTIONS = {
        :no_crop => lambda { |o, v| o << '--no-crop' if v },
        :sheet => lambda { |o, v| o << '--sheet' << v if v },
        :sheet_index => lambda { |o, v| o << '--sheet-index' << v if v },
        :layers => lambda { |o, v| o << '--layers' << v if v },
        :layer_indexes => lambda { |o, v| o << '--layer-ids' << v if v },
      }

      def supported_formats
        [:png, :pdf, :svg]
      end

      def collect_options(source)
        options = {}
        
        OPTIONS.keys.each do |option|
          attr_name = option.to_s.tr('_', '-')
          options[option] = source.attr(attr_name) || source.attr(attr_name, nil, 'drawio-option')
        end
        
        options
      end

      def convert(source, format, options)
        generate_file(source.find_command('draw-exporter'), "drawio", format.to_s, source.to_s) do |tool_path, source_path, output_path|
          args = [tool_path, format.to_s]

          options.each do |option, value|
            OPTIONS[option].call(args, value)
          end

          args << Platform.native_path(source_path)
          args << Platform.native_path(output_path)
        end
      end
    end
  end
end
