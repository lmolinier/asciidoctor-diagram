require_relative 'converter'
require_relative '../diagram_processor'

module Asciidoctor
  module Diagram
    class DrawioBlockProcessor < DiagramBlockProcessor
      use_converter DrawioConverter
    end

    class DrawioBlockMacroProcessor < DiagramBlockMacroProcessor
      use_converter DrawioConverter
    end

    class DrawioInlineMacroProcessor < DiagramInlineMacroProcessor
      use_converter DrawioConverter
    end
  end
end