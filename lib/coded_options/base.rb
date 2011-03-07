module CodedOptions

  def self.included base
    base.send :extend, ClassMethods
  end

  @initial_value = 0

  module PrivateClassMethods
    attr_accessor :initial_value
  end
  extend PrivateClassMethods

  module ClassMethods
    def coded_options *args
      case args.length
        when 1 then
          hash = args.first
          if (new_initial_value = hash.delete(:initial_value))
            old_initial_value = CodedOptions.initial_value
            CodedOptions.initial_value = new_initial_value

            hash.each {|name, values| setup_coded_options name, values }

            CodedOptions.initial_value = old_initial_value
          else
            hash.each {|name, values| setup_coded_options name, values }
          end
        when 2 then setup_coded_options *args
        else raise("Error in coded_options syntax, expecting name and values or a hash, got #{args.inspect}")
      end
    end

    private

    def setup_coded_options singular_name, values
      plural_name = singular_name.to_s.pluralize
      options = to_options(values)

      field = "#{singular_name}_id"
      values_constant = plural_name.upcase
      options_constant = "#{singular_name}_options".upcase

      const_set options_constant, options
      const_set values_constant, Hash[*options.map(&:reverse).flatten]

      class_eval <<-EOT, __FILE__, (__LINE__+1)
        def #{singular_name}                                                   # def state
          return unless #{field}                                               #   return unless state_id
          #{values_constant}[#{field}.to_i]                                    #   STATES[state_id.to_i]
        end                                                                    # end

        def #{singular_name}= new_value                                        # def state= new_value
          _, id = #{options_constant}.detect {|value, id| value == new_value } #   _, id = STATE_OPTIONS.detect {|value, id| value == new_value }
          send :#{field}=, id                                                  #   send :state_id=, id
        end                                                                    # end
      EOT
    end

    def to_options values
      if values.is_a? Hash
        values.sort{|a,b| a.first <=> b.first }.map{|a| a.reverse }
      else
        ids = (CodedOptions.initial_value..(CodedOptions.initial_value + values.length)).to_a
        values.zip(ids)
      end
    end
  end

end
