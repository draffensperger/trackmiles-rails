require File.expand_path('../../spec_helper', __FILE__)

describe JobQueue do
  before do
    @q = JobQueue.new 2
    $job_queue_results = ThreadSafeSet.new
    $job_queue_runs = 0
    $job_queue_runs_mutex = Mutex.new
  end

  class TestWorker
    def perform(item, delay)
      sleep delay
      $job_queue_results.add item
      $job_queue_runs_mutex.synchronize { $job_queue_runs += 1 }
    end
  end

  it 'should queue and run a job' do
    expect($job_queue_results.member? 'a').to be_falsey
    @q.enqueue(TestWorker, 'a', 0)
    @q.wait_for_all_jobs
    expect($job_queue_results.member? 'a').to be_truthy
  end

  it 'should run multiple jobs in background' do
    expect($job_queue_results.member? 'a').to be_falsey
    expect($job_queue_results.member? 'b').to be_falsey
    @q.enqueue(TestWorker, 'a', 0.05)
    @q.enqueue(TestWorker, 'b', 0.05)
    expect($job_queue_results.member? 'a').to be_falsey
    expect($job_queue_results.member? 'b').to be_falsey
    sleep 0.1
    expect($job_queue_results.member? 'a').to be_truthy
    expect($job_queue_results.member? 'b').to be_truthy
  end

  it 'should run concurrent non-unique jobs' do
    @q.enqueue(TestWorker, 'a', 0.05)
    @q.enqueue(TestWorker, 'a', 0.05)
    sleep 0.1
    expect($job_queue_runs).to eq(2)
  end

  it 'should not start currently running unique jobs' do
    @q.make_job_unique(TestWorker, 'a', 0.05)
    @q.enqueue(TestWorker, 'a', 0.05)
    @q.enqueue(TestWorker, 'a', 0.05)
    sleep 0.1
    expect($job_queue_runs).to eq(1)

    @q.enqueue(TestWorker, 'a', 0.05)
    sleep 0.1
    expect($job_queue_runs).to eq(2)
  end
end