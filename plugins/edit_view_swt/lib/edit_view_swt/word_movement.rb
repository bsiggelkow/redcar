
module Redcar
  class EditViewSWT
    class WordMoveListener
      MOVE_FORWARD_RE = /\s{3,}|[^\w]{2,}|(\s|[^\w])?\w+/
    
      def initialize(controller)
        @controller = controller
      end
      
      def get_next_offset(e)
        if e.movement == Swt::SWT::MOVEMENT_WORD
          e.newOffset = next_offset(e.offset, e.lineOffset, e.lineText)
        end
      end
      
      def next_offset(offset, line_offset, line_text)
        if offset == line_offset + line_text.length
          offset + 1
        else
          future_text = line_text[(offset - line_offset)..-1]
          if future_text == nil or future_text == ""
            line_offset + line_text.length
          else
            if md = future_text.match(MOVE_FORWARD_RE)
              offset + md.end(0)
            else
              line_offset + line_text.length
            end
          end
        end
      end
      
      def get_previous_offset(e)
        if e.movement == Swt::SWT::MOVEMENT_WORD
          e.newOffset = previous_offset(e.offset, e.lineOffset, e.lineText)
        end
      end
      
      def previous_offset(offset, line_offset, line_text)
        if offset == line_offset
          offset - 1
        else
          future_text = line_text[0..(offset - line_offset - 1)].reverse
          if future_text == nil or future_text == ""
            line_offset
          else
            if md = future_text.match(MOVE_FORWARD_RE)
              offset - md.end(0)
            else
              line_offset
            end
          end
        end
      end
    end
  end
end