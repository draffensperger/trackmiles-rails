class JobQueue
 def initialize(num_workers)
    @q = Queue.new
    @threads = num_workers.times.map { make_thread }
    @jobs_mutex = Mutex.new
    @unique = Set.new
    @running = Set.new
  end

  def enqueue(klass, *args)
    job = {klass: klass.name, args: args}
    Rails.debug.info "Enqueuing job: #{job}"
    @q.enq job
  end

  def make_job_unique(klass, *args)
    job = {klass: klass.name, args: args}
    Rails.debug.info "Making job unique: #{job}"
    @jobs_mutex.synchronize { @unique.add job }
  end

  def wait_for_all_jobs
    until @q.empty?
      sleep 0.1
      Thread.pass
    end
  end

private
  def make_thread
    Thread.new do
      t = Thread.current
      t.priority -= 1
      t.abort_on_exception = true
      Rails.debug.info "Created worker thread: #{t}"
      while true
        process_job @q.deq
        Thread.pass
      end
    end
  end

  def should_run_and_mark_running(job)
    @jobs_mutex.synchronize do
      Rails.debuginfo "Running: #{@running.inspect}"
      Rails.debug.info "Unique: #{@unique.inspect}"
      should_run = !(@running.member? job and @unique.member? job)
      @running.add job if should_run
      should_run
    end
  end

  def process_job(job)
    if should_run_and_mark_running job
      Rails.logger.info "Starting job: #{job}"
      job[:klass].constantize.new.perform *job[:args]
      Rails.logger.info "Completed job: #{job}"
      @jobs_mutex.synchronize { @running.delete job }
    end
  end
end