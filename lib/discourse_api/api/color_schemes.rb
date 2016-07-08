module DiscourseApi
  module API
    module ColorSchemes

      def set_color_scheme(id, name, enabled=true, primary="222222", secondary="ffffff", tertiary="0088cc",
                           quaternary="e45735", header_background="ffffff",
                           header_primary="333333", danger="e45735", success="009900", love="fa6c8d", wiki="408040")

        args = {name: name, enabled: enabled, colors: []}

        %w(primary secondary tertiary quaternary header_background header_primary danger success love wiki).each do |k|
          args[:colors] << {name: k, hex: eval(k)}
        end
        real_id = id
        if id.nil?
          cs = get("/admin/color_schemes.json")
          if cs[:body].class == Array
            cs[:body].each do |cs_hash|
              if !cs_hash["is_base"]
                real_id = cs_hash["id"]
              end
            end
          end
        end
        if real_id.nil?
          post("/admin/color_schemes.json", {color_scheme: args})
        else
          put("/admin/color_schemes/#{real_id.to_s}.json", {color_scheme: args})
        end
      end
    end
  end
end
