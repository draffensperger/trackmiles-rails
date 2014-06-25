class SimpleJobQueue
 def initialize(num_workers)
    @q = Queue.new
    @threads = num_workers.times.map { make_thread }
    @unique_jobs = ThreadSafeSet.new
    @running_jobs = ThreadSafeSet.new
  end

  def enqueue(klass, *args)
    @q.enq klass: klass, args: args
  end

  def make_job_unique(job)
    unique_jobs.add job
  end

  def wait_for_all_jobs
    until @q.empty?
      sleep 0.1
      pass
    end
  end

private
  def make_thread
    Thread.new do
      Thread.current.priority -= 2
      while true
        process_job q.deq
        Thread.current.pass
      end
    end
  end

  def run_job(job)
    @running_jobs.add job
    job[:klass].constantize.new.perform *job[:args]
    @running_jobs.delete job
    @unique_jobs.delete job
  end

  def process_job(job)
    unless @running_jobs.member? job and @unique_jobs.member? job
      run_job job
    end
  end
end