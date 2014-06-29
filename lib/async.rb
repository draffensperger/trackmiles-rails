# Based on https://github.com/CruGlobal/mpdx/blob/857c629580eff5ad7dd6e17311261ea1cefa7502/lib/async.rb
module Async
  # This will be called by a worker when a job needs to be processed
  def perform(id, method, *args)
    ActiveRecord::Base.connection_pool.with_connection do
      if id
        begin
          self.class.find(id).send(method, *args)
        rescue ActiveRecord::RecordNotFound
          # If this instance has been deleted, oh well.
        end
      else
        send(method, *args)
      end
    end
  end

  # We can pass this any Repository instance method that we want to
  # run later.
  def async(method, *args)
    @@q ||= JobQueue.new(ENV['ASYNC_WORKER_THREADS'] || 2)
    @@q.enqueue_unique self.class, id, method, *args
    #@@q.enqueue self.class, id, method, *args
  end

  def self.wait_for_all_jobs
    @@q.wait_for_all_jobs
  end
end