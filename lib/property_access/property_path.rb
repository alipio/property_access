# frozen_string_literal: true

class PropertyAccess
  module PropertyPath
    module_function

    def parse_property_path(path)
      path ||= ""
      elements = []

      if !path.empty? && path[0] == "."
        raise InvalidPropertyPath, "expected property path to start with a name or index"
      end

      until path.empty?
        case path[0]
        when "."
          path = path[1..]
          if path.empty?
            raise InvalidPropertyPath, "expected property path to end with a name or index"
          end
          if path[0] == "["
            raise InvalidPropertyPath, "expected property name after '.'"
          end
        when "["
          # If the character following the '[' is a '"', parse a string key.
          path_elem = nil
          if path.length > 1 && path[1] == '"'
            property_key = +""
            i = 2
            loop do
              if i >= path.length
                raise InvalidPropertyPath, "missing closing quote in property name"
              elsif path[i] == '"'
                i += 1
                break
              elsif path[i] == "\\" && i + 1 < path.length && path[i + 1] == '"'
                property_key << '"'
                i += 2
              else
                property_key << path[i]
                i += 1
              end
            end
            raise InvalidPropertyPath, "missing closing bracket in property access" if i >= path.length || path[i] != "]"

            path_elem, path = property_key, path[i..]
          else
            rbracket = path.index("]")
            raise InvalidPropertyPath, "missing closing bracket in array index" unless rbracket

            segment = path[1..rbracket - 1]
            if segment == "*"
              path_elem, path = "*", path[rbracket..]
            else
              index = Integer(segment) rescue nil
              raise InvalidPropertyPath, "invalid array index: `#{segment}'" unless index

              path_elem, path = index, path[rbracket..]
            end
          end
          elements << path_elem
          path = path[1..]
        else
          i = 0
          loop do
            if i == path.length || path[i] == "." || path[i] == "["
              elements << path[0..i - 1]
              path = path[i..]
              break
            end
            i += 1
          end
        end
      end

      elements
    end
  end
end
