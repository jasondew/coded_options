module CodedOptions

  def coded_options *args
    case args.length
      when 1 then args.first.each {|name, values| setup_coded_options name, values }
      when 2 then setup_coded_options *args
      else raise("Error in coded_options syntax, expecting name and values or a hash, got #{args.inspect}")
    end
  end

  private

  def setup_coded_options singular_name, values
    plural_name = singular_name.to_s.pluralize

    const_set plural_name.upcase, values
    const_set "#{singular_name}_options".upcase, to_options(values)

    class_eval <<-EOT, __FILE__, (__LINE__+1)
      def #{singular_name}                                                 # def state
        return unless #{singular_name}_id                                  #   return unless state_id
        #{plural_name.upcase}[#{singular_name}_id.to_i]                    #   STATES[state_id.to_i]
      end                                                                  # end

      def #{singular_name}= new_value                                       # def state= new_value
        send :#{singular_name}_id=, #{plural_name.upcase}.index(new_value)  #   send :state_id=, STATES.index(new_value)
      end                                                                   # end
    EOT
  end

  def to_options values
    if values.is_a? Hash
      values.sort{|a,b| a.first <=> b.first}.map{|a| a.reverse}
    else
      values.zip((0..values.length).to_a)
    end
  end

end
