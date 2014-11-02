FROM rails:onbuild

RUN rake assets:precompile

CMD rake db:migrate && rails server

