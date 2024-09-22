class AddStreamingServicesToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :streaming_services, :json
  end
end
