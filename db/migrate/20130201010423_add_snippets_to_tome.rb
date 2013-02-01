class AddSnippetsToTome < ActiveRecord::Migration
  def change
    add_column :tomes, :progress, :text, :default=>"Put in story ending here paginated by ||. End subchapter with |c|. Write subchapter heading. Start next chapter with |c| and paginated with ||"
  end
end
