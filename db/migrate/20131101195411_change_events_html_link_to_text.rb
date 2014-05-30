class ChangeEventsHtmlLinkToText < ActiveRecord::Migration
  def change
    change_column :events, :html_link, :text
  end
end
