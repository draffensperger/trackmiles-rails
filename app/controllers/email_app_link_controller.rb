class EmailAppLinkController < ApplicationController
  # From: http://stackoverflow.com/questions/4776907/what-is-the-best-easy-way-to-validate-an-email-address-in-ruby
  def valid_email?(email)   
    qtext = '[^\\x0d\\x22\\x5c\\x80-\\xff]'
    dtext = '[^\\x0d\\x5b-\\x5d\\x80-\\xff]'
    atom = '[^\\x00-\\x20\\x22\\x28\\x29\\x2c\\x2e\\x3a-' +
      '\\x3c\\x3e\\x40\\x5b-\\x5d\\x7f-\\xff]+'
    quoted_pair = '\\x5c[\\x00-\\x7f]'
    domain_literal = "\\x5b(?:#{dtext}|#{quoted_pair})*\\x5d"
    quoted_string = "\\x22(?:#{qtext}|#{quoted_pair})*\\x22"
    domain_ref = atom
    sub_domain = "(?:#{domain_ref}|#{domain_literal})"
    word = "(?:#{atom}|#{quoted_string})"
    domain = "#{sub_domain}(?:\\x2e#{sub_domain})*"
    local_part = "#{word}(?:\\x2e#{word})*"
    addr_spec = "#{local_part}\\x40#{domain}"
    email_pattern = /\A#{addr_spec}\z/
    
    email =~ email_pattern
  end
  
  def email_android_link
    render json: {success: 'ok'}
  end
    
  def email_android_link2
    @email = params[:email]
    
    if @email.valid_email?
      render json: {success: 'ok'}
      return
    else
      render json: {bad_email: 'ok'}
      return
    end
    
    ActionMailer::Base.mail(
        from: ENV['SERVER_FROM_EMAIL'], 
        to: params[:email], 
        :subject => "test", 
        :body => "test"
      ).deliver    
  end
end
