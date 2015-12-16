module DiscourseApi
  module API
    module SiteSettings

      def set_site_setting(name, value)
        args = {}
        args[name] = value
        put("/admin/site_settings/#{name}", args)
      end
    end
  end
end