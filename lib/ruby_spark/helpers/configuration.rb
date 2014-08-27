module RubySpark
  module Configuration

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def configuration
        yield self
      end

      def define_setting(name, default = nil)
        class_variable_set("@@#{name}", default)

        define_class_method "#{name}=" do |value|
          class_variable_set("@@#{name}", value)
        end

        define_class_method name do
          class_variable_get("@@#{name}")
        end
      end

      private

      def define_class_method(name, &block)
        (class << self; self; end).instance_eval { define_method name, &block }
      end
    end

  end
end
