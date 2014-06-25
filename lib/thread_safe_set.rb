class ThreadSafeSet
  def initialize
    @s = Set.new
    @m = Mutex.new
  end
  def member?(x)
    @m.synchronize { @s.member? x }
  end
  def add(x)
    @m.synchronize { @s.add x }
  end
  def delete(x)
    @m.synchronize { @s.delete x }
  end
end