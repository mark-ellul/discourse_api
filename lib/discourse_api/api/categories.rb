module DiscourseApi
  module API
    module Categories
      # :color and :text_color are RGB hexadecimal strings
      # :permissions is a hash with the group name and permission_type which is an integer 1 = Full 2 = Create Post 3 = Read Only
      def create_category(args)
        custom_keys = args.keys.select{|key| key.to_s.start_with?("custom") }
        if !custom_keys.empty? 
          args[:custom_fields] ||= {}
          custom_keys.each do |custom_key|
            args[:custom_fields][custom_key] = args[custom_key]
          end
        end

        args = API.params(args)
                  .required(:name, :color, :text_color)
                  .optional(:description, :permissions, :parent_category_id, :suppress_from_homepage, :custom_fields, :custom_context_type, :custom_context_id, :read_restricted)
                  .default(parent_category_id: nil)
        debugger
        response = post("/categories", args)
        response['category']
      end

      def categories(params={})
        response = get('/categories.json', params)
        response[:body]['category_list']['categories']
      end

      def category_latest_topics(category_slug)
        response = get("/category/#{category_slug}/l/latest.json")
        response[:body]['topic_list']['topics']
      end

      def category_top_topics(category_slug)
        response = get("/category/#{category_slug}/l/top.json")
        response[:body]['topic_list']['topics']
      end

      def category_new_topics(category_slug)
        response = get("/category/#{category_slug}/l/new.json")
        response[:body]['topic_list']['topics']
      end

      def category(id)
        response = get("/c/#{id}/show")
        response.body['category']
      end
    end
  end
end
