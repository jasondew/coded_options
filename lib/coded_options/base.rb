module CodedOptions
  module Constants
  end

  def self.extended base
    base.send(:include, Constants)
  end

  def coded_options singular_name, values
    plural_name = singular_name.to_s.pluralize

    Constants.const_set plural_name.upcase, values
    Constants.const_set "#{singular_name}_options".upcase, to_options(values)

    class_eval <<-EOT, __FILE__, (__LINE__+1)
      def #{singular_name}                          # def state
        return unless #{singular_name}_id           #   return unless state_id
        Constants::#{plural_name.upcase}[#{singular_name}_id]  #   STATES[state_id]
      end                                           # end
    EOT
  end

  private

  def to_options values
    values.zip((0..values.length).to_a)
  end

end
