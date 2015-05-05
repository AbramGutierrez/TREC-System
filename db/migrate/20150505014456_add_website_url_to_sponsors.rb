class AddWebsiteUrlToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :website_url, :string
  end
end
