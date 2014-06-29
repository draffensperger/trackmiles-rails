require './spec/spec_helper'
require 'pg'

describe 'Home page view', type: :feature do
  before do
    @app_host = 'https://stagetrackmiles.davidraff.com'
    @ssh_host = 'ssh.davidraff.com'

    WebMock.disable!
    Capybara.app_host = @app_host
    Capybara.register_driver :selenium_chrome do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
    Capybara.default_driver = :selenium_chrome

    # Connect to Postgres on the remote server via an SSH tunnel
    app_env = `ssh dokku@#{@ssh_host} config stagetrackmiles`
    db_re = /DATABASE_URL:\s+\"?postgres:\/\/([^:]+):([^@]+)@[^\/]+\/([^\n\"]+)/
    user, pw, db = db_re.match(app_env).captures
    Rails.logger.info "Retrieved Dokku DATABASE_URL for user #{user} on #{db}"

    @tunnel_pid = Process.spawn "ssh deploy@#{@ssh_host} -N -L 55432:localhost:5432"
    Rails.logger.info "SSH Tunnel for Postgres on PID #{@tunnel_pid}"

    sleep 2
    @cn = PG::Connection.new host: 'localhost', port: 55432, dbname: db,
                             user: user, password: pw
    Rails.logger.info "Postgres connection established: #{@cn}"

    # Clear out the database records
    ActiveRecord::Base.subclasses.each do |model|
      @cn.exec "DELETE FROM #{model.table_name}"
      Rails.logger.debug "Deleted rows in table: #{model.table_name}"
    end
  end

  def query_google_token(email)
    sql = 'SELECT google_auth_token FROM users WHERE email = $1'
    @cn.exec(sql, [email]).values[0][0]
  end

  after do
    @cn.close
    Rails.logger.info "Sending TERM to SSH Postgres tunnel at PID #{@tunnel_pid}"
    Process.kill 'TERM', @tunnel_pid
    #WebMock.enable!
  end

  it 'shows home page' do
    visit '/'
    expect(page).to have_content 'Sign in with Google'
    click_link 'Sign in with Google'

    expect(page).to have_content 'Sign in with your Google Account'
    fill_in 'Email', with: ENV['TEST_GOOGLE_ACCOUNT']
    fill_in 'Password', with: ENV['TEST_GOOGLE_PASSWORD']
    click_button 'signIn'

    expect(page).to have_content 'This app would like to'
    click_button 'submit_approve_access'

    expect(page).to have_content 'Successfully authenticated from Google account'

    token = query_google_token ENV['TEST_GOOGLE_ACCOUNT']
    dataset = 'day1'
    data_dir = "spec/data/trip_separation/#{dataset}/"
    trip_attrs = CSVUtil.load_as_hashes(data_dir + 'trips.csv')
    all_locs = CSVUtil.load_as_hashes(data_dir + 'locations.csv')
    batch_size = 32

    all_locs.each_slice(batch_size).with_index do |(*locs), i|
      result = ApiUtil.post_json "#{@app_host}/api/v1/locations/bulk_create",
                               google_token: token, locations: locs
      expect(result).to eq({num_created_locations: locs.length})
      Rails.logger.info "Simulated mobile upload of #{locs.length} locations: #{result}"
    end

    # Allow some time for the API background job to process
    sleep 5.0

    visit '/trips'
  end
end