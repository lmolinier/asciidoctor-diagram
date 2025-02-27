require_relative 'test_helper'

DRAWIO_DIAGRAM = <<-eos
<mxfile host="Electron" modified="2021-11-15T13:32:35.319Z" agent="5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) draw.io/15.7.3 Chrome/91.0.4472.164 Electron/13.6.1 Safari/537.36" etag="7Kwj1Dk9rrArAG1jnUv6" compressed="false" version="15.7.3" type="device" pages="2">
  <diagram id="39dSL4geXcCnPDmTARuJ" name="Page-1">
    <mxGraphModel dx="1102" dy="857" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
        <mxCell id="wNFrfZCqjf5Y7_IN85FA-1" value="Page-1 SAMPLE" style="text;html=1;strokeColor=#6c8ebf;fillColor=#dae8fc;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;" parent="1" vertex="1">
          <mxGeometry x="260" y="350" width="280" height="140" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
  <diagram id="Zkv99t4N1JXZBNUkwIkO" name="Page-2">
    <mxGraphModel dx="1102" dy="857" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="827" pageHeight="1169" math="0" shadow="0">
      <root>
        <mxCell id="3_V4tw8OJjJ2u9C4XTe2-0" />
        <mxCell id="3_V4tw8OJjJ2u9C4XTe2-1" value="Layer-1" parent="3_V4tw8OJjJ2u9C4XTe2-0" />
        <mxCell id="AHEhDlAdO_O8EXVOMgdq-0" value="Page-2 SAMPLE&lt;br&gt;layer-1" style="text;html=1;strokeColor=#6c8ebf;fillColor=#dae8fc;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="3_V4tw8OJjJ2u9C4XTe2-1">
          <mxGeometry x="280" y="310" width="280" height="140" as="geometry" />
        </mxCell>
        <mxCell id="AHEhDlAdO_O8EXVOMgdq-2" value="Layer-2" parent="3_V4tw8OJjJ2u9C4XTe2-0" />
        <mxCell id="AHEhDlAdO_O8EXVOMgdq-1" value="Page-2 SAMPLE&lt;br&gt;layer-2" style="text;html=1;strokeColor=#6c8ebf;fillColor=#dae8fc;align=center;verticalAlign=middle;whiteSpace=wrap;rounded=0;" vertex="1" parent="AHEhDlAdO_O8EXVOMgdq-2">
          <mxGeometry x="280" y="160" width="280" height="140" as="geometry" />
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
eos

describe Asciidoctor::Diagram::DrawioInlineMacroProcessor do
  include_examples "inline_macro", :drawio, DRAWIO_DIAGRAM, [:png, :svg, :pdf]
end

describe Asciidoctor::Diagram::DrawioBlockMacroProcessor do
  include_examples "block_macro", :drawio, DRAWIO_DIAGRAM, [:png, :svg, :pdf]
end

describe Asciidoctor::Diagram::DrawioBlockProcessor do
  include_examples "block", :drawio, DRAWIO_DIAGRAM, [:png, :svg, :pdf]

  it "should support drawio options as attributes" do
    doc = <<-eos
:drawio-option-crop: true
= Hello, DrawIO!
Doc Writer <doc@example.com>

== First Section

[drawio, crop=true]
    eos
    doc << DRAWIO_DIAGRAM

    d = load_asciidoc doc
    expect(d).to_not be_nil

    b = d.find { |bl| bl.context == :image }
    expect(b).to_not be_nil
    target = b.attributes['target']
    expect(target).to match(/\.png$/)
    expect(File.exist?(target)).to be true
  end
end