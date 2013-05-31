class AddEnviadaEmToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :enviada_em, :datetime
  end
end
