module Test
  module Spec
    class << self
      def configure
        yield configuration
      end
      
      def configuration
        # || works but ||= silences a warning
        @configuration ||= reset_configuration!
      end
      
      def reset_configuration!
        @configuration = Test::Spec::Configuration.new
      end
    end
    
    class Configuration
      def before(scope = :each, &block)
        send("before_#{scope}_blocks") << block
      end
      
      def after(scope = :each, &block)
        send("after_#{scope}_blocks") << block
      end
      
      def run_blocks(test_case, which, scope)
        blocks_for(which, scope).each do |block|
          test_case.instance_eval &block
        end
      end
      
      private
      def blocks_for(which, scope)
        send(block_reader_name(which, scope))
      end

      class << self
        def block_ivar_name(which, scope)
          "@#{which}_#{scope}_blocks"
        end
      
        def block_reader_name(which, scope)
          "#{which}_#{scope}_blocks"
        end

        def each_type(&block)
          [:before, :after].each(&block)
        end
      
        def each_scope(&block)
          [:each, :all].each(&block)
        end
      end
      
      each_type do |which|
        each_scope do |scope|
          ivar = block_ivar_name(which, scope)
          define_method(block_reader_name(which, scope)) do
            instance_variables.include?(ivar) ? instance_variable_get(ivar) : instance_variable_set(ivar, [])
          end
        end
      end
      
      def each_type; self.class.each_type; end
      def each_scope; self.class.each_scope; end
      def block_ivar_name(which, scope); self.class.block_ivar_name(which, scope); end
      def block_reader_name(which, scope); self.class.block_reader_name(which, scope); end
    end
  end
end