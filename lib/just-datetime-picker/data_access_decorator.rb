require 'active_admin'

::ActiveAdmin::ResourceController::DataAccess.module_eval do

  def clean_search_params(search_params)
    return {} unless search_params.is_a?(Hash)
    search_params = search_params.dup
    search_params.delete_if do |key, value|
      value == ""
    end
    search_params = concat_datetime(search_params)
  end


  def concat_datetime(search_params)
    delete_keys = []
    new_hash = {}
    search_params.each do |key, value|
      if key.starts_with?('just_datetime_picker_')

        delete_keys << key
        original_key = key.gsub('just_datetime_picker_', '')

        if value.is_a?(Array)
          date = value.delete_at(0)
          time = value.join
          value = "#{date} #{time}"
        end

        new_hash.merge!({original_key => value})
      end
    end
    delete_keys.each do |k|
      search_params.delete(k)
    end
    search_params.merge(new_hash)
  end


end