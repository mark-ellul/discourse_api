module DiscourseApi
  module API
    module Groups
      def create_group(args)
        args = API.params(args)
        .required(:name)
        .default(visible: true)
        .to_h
        post("/admin/groups.json", args)
      end

      def groups
        response = get("/admin/groups.json")
        response[:body]
      end

      def group_add(group_id, users)
        users.keys.each do |key|
          # Accept arrays and convert to comma-delimited string.
          if users[key].respond_to? :join
            users[key] = users[key].join(",")
          end

          # Accept non-plural user_id or username, but send pluralized version in the request.
          if key.to_s[-1] != 's'
            users["#{key}s"] = users[key]
            users.delete(key)
          end
        end

        put("/admin/groups/#{group_id}/members.json", users)
      end

      def group_members(group_id)
        response = get("/admin/groups/#{group_id}/members.json", {limit: 1000})
        response[:body]
      end


      def group_remove(group_id, user)
        delete("/admin/groups/#{group_id}/members.json", user)
      end

      def delete_group(group_id)
        delete("/admin/groups/#{group_id}.json")
      end
    end
  end
end
