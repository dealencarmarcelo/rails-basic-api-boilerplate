module Initializable
  def values(*args)
    define_method(:initialize) do |*parameters|
      raise ArgumentError, 
            "wrong number of args (given #{parameters.size}, 
            expected #{args.size})" unless args.size == parameters.size
      
      args.zip(parameters).each do |argument, parameter|
        instance_variable_set("@#{argument}", parameter)
      end
    end
  end
end
