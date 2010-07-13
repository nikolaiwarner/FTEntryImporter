class Administration::EntryImporter::EntryImporterController < ApplicationController
  only_for_user

  def index
    @data_models = DataModel.for_host(current_host).find :all
  end

  def import
    if EntryImporter.import params[:entry_importer]
      flash[:notice] = "Import successful!"
    else
      flash[:notice] = "Import encountered an error."
    end
    redirect_to administration_entry_importer_root_path
  end

end
