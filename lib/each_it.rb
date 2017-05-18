require_relative "./each_it/version"

module EachIt
  def each(*args, &block)
    super(*args) do |i|
      o = Object.new
      o.define_singleton_method :method_missing, ->(name, *a, &b) { i.send(name, *a, &b) }
      o.define_singleton_method :it, -> { i }
      o.define_singleton_method :call, -> { instance_eval(&block) }
      o.call
    end
  end
end

Enumerable.prepend EachIt
Array.prepend EachIt
Hash.prepend EachIt
