module DiscourseApi
  module API
    module SiteCustomizations

      def set_site_customizations(enabled = true, name="Site", stylesheet = "", header="", top = "", footer = "",
                                  mobile_stylesheet ="", mobile_header="", mobile_top="", mobile_footer="", head_tag="", body_tag="", embedded_css="" )
        # get all of them
        
        cs = get("/admin/site_customizations.json")

        site_customization_id = nil

        # if there aren't any create one
        cs[:body]["site_customizations"].each do |cs_hash|
          site_customization_id = cs_hash["id"]
          break
        end

        # save it
        args = {name: name, enabled: enabled, stylesheet: stylesheet, header: header, top: top,
                footer: footer, mobile_stylesheet: mobile_stylesheet, mobile_header: mobile_header, mobile_top: mobile_top,
                mobile_footer: mobile_footer, head_tag: head_tag, body_tag: body_tag, embedded_css: embedded_css}

        if site_customization_id.nil?
          res  = post("/admin/site_customizations.json",  {site_customization: args})
        else
          res = put("/admin/site_customizations/#{site_customization_id}.json", {site_customization: args})
        end

        res
      end
    end
  end
end

#
#site_customization[enabled]:true
#site_customization[name]:New Style
#site_customization[stylesheet]:body { background-image: url(//d1eiaohmoztxq3.cloudfront.net/custom_designs/background_images/9/original/bg_paper_organic.jpg);
#                                      background-repeat: repeat;
#
#                                      overflow-y: auto;
#                                      }
#                 .content { background-color: #FFFFFF !important}
#site_customization[header]:
#  site_customization[top]:
#  site_customization[footer]:
#  site_customization[mobile_stylesheet]:
#  site_customization[mobile_header]:
#  site_customization[mobile_top]:
#  site_customization[mobile_footer]:
#  site_customization[head_tag]:
#  site_customization[body_tag]:
#  site_customization[embedded_css]:
