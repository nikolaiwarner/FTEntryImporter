config.gem 'mussegam-csvscan', :lib => 'csvscan'

require File.join(File.dirname(__FILE__), 'lib', 'entry_importer')


# Importer Links
ViewExtender.register(
  'dashboard/entry/index/right_column',
  :bottom,
  'dashboard/entry/index/right_column',
  :file => "#{File.dirname(__FILE__)}/app/views/administration/entry_importer/_task_link.haml"
  #:partial => "administration/entry_importer/_task_link.haml"
)

ViewExtender.register(
  'dashboard/data_model/index/right_column',
  :bottom,
  'dashboard/data_model/index/right_column',
  :file => "#{File.dirname(__FILE__)}/app/views/administration/entry_importer/_task_link.haml"
  #:partial => "administration/entry_importer/_task_link.haml"
)
