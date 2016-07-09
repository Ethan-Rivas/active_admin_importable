module ActiveAdminImportable
  module DSL
    def active_admin_importable(&block)
      action_item :only => :index do
        link_to "Importar", :action => 'subir_csv'
      end

      collection_action :subir_csv do
        render "admin/csv/upload_csv"
      end

      collection_action :importar_csv, :method => :post do
        CsvDb.convert_save(active_admin_config.resource_class, params[:dump][:file], &block)
        redirect_to :action => :index, :notice => "#{active_admin_config.resource_name.to_s} importados!"
      end
    end
  end
end
