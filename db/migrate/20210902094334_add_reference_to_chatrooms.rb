class AddReferenceToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :chatrooms, :service, null: false, foreign_key: true
  end
end
