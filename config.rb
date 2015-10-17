Bundler.require(:default)

class TrailingTreeprocessor < Asciidoctor::Extensions::Treeprocessor
  def process document
    return unless document.blocks?
    process_blocks document
    nil
  end

  def process_blocks node
    node.blocks.each_with_index do |block, index|
      if block.context == :paragraph
        node.blocks[index] = create_paragraph block.document, block.content.gsub("\n", ''), block.attributes
      else
        process_blocks block
      end
    end
  end
end

Asciidoctor::Extensions.register do
  treeprocessor TrailingTreeprocessor
end
