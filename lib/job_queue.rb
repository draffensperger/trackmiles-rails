class JobQueue
  def initialize(num_workers)
    @q = Queue.new
    @threads = num_workers.times.map { make_thread }
    @mutex = Mutex.new
    @unique = Set.new
    @running = Set.new
    @wait_threads = []
  end

  def enqueue(klass, *args)
    job = {klass: klass.name, args: args}
    Rails.logger.debug "Enqueuing job: #{job}"
    @q.enq job
    Rails.logger.debug "Job queue size: #{@q.size}"
  end

  def enqueue_unique(klass, *args)
    make_job_unique klass, *args
    enqueue klass, *args
  end

  def make_job_unique(klass, *args)
    job = {klass: klass.name, args: args}
    Rails.logger.debug "Making job unique: #{job}"
    @mutex.synchronize { @unique.add job }
  end

  def wait_for_all_jobs
    Thread.stop if @mutex.synchronize {
      should_wait = !(@running.empty? and @q.empty?)
      @wait_threads.push Thread.current if should_wait
      Rails.logger.debug "Waiting for jobs ..." if should_wait
      should_wait
    }
  end

private
  def make_thread
    Thread.new do
      t = Thread.current
      t.priority -= 1
      t.abort_on_exception = true
      Rails.logger.debug "Created worker thread: #{t}"
      while true
        process_job @q.deq
        Thread.pass
      end
    end
  end

  def should_run_and_mark_running(job)
    @mutex.synchronize do
      Rails.logger.debug "Running jobs set: #{@running.inspect}"
      Rails.logger.debug "Unique jobs set: #{@unique.inspect}"
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
      @mutex.synchronize {
        @running.delete job
        @wait_threads.each {|t| t.run} if @running.empty? and @q.empty?
      }
    end
  end
end