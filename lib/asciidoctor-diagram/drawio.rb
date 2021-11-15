require 'asciidoctor/extensions'
require_relative 'drawio/extension'

Asciidoctor::Extensions.register do
  block Asciidoctor::Diagram::DrawioBlockProcessor, :drawio
  block_macro Asciidoctor::Diagram::DrawioBlockMacroProcessor, :drawio
  inline_macro Asciidoctor::Diagram::DrawioInlineMacroProcessor, :drawio
end
