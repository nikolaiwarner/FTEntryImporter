ActionController::Routing::Routes.draw do |map|

  map.namespace :administration do |admin|
    admin.namespace :entry_importer do |ei|   
      ei.root :controller => 'entry_importer', :action => 'index'
      ei.import 'import', :controller => 'entry_importer', :action => 'import'
    end    
  end  
  
end

