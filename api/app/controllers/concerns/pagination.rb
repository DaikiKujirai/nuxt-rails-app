module Pagination
  class Api::V1::PostsController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagination: {
          current:     resources.current_page,
          previous:    resources.prev_page   ,
          next:        resources.next_page   ,
          limit_value: resources.limit_value ,
          pages:       resources.total_pages ,
          count:       resources.total_count
        }
      }
    end
  end

  class Api::V1::UsersController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagination: {
          current:     resources.current_page,
          previous:    resources.prev_page   ,
          next:        resources.next_page   ,
          limit_value: resources.limit_value ,
          pages:       resources.total_pages ,
          count:       resources.total_count
        }
      }
    end
  end

  class Api::V1::LikesController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagination: {
          current:     resources.current_page,
          previous:    resources.prev_page   ,
          next:        resources.next_page   ,
          limit_value: resources.limit_value ,
          pages:       resources.total_pages ,
          count:       resources.total_count
        }
      }
    end
  end

  class Api::V1::RelationshipsController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagination: {
          current:     resources.current_page,
          previous:    resources.prev_page   ,
          next:        resources.next_page   ,
          limit_value: resources.limit_value ,
          pages:       resources.total_pages ,
          count:       resources.total_count
        }
      }
    end
  end
  class Api::V1::ChatRoomsController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagination: {
          current:     resources.current_page,
          previous:    resources.prev_page   ,
          next:        resources.next_page   ,
          limit_value: resources.limit_value ,
          pages:       resources.total_pages ,
          count:       resources.total_count
        }
      }
    end
  end
  class Api::V1::NotificationsController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagination: {
          current:     resources.current_page,
          previous:    resources.prev_page   ,
          next:        resources.next_page   ,
          limit_value: resources.limit_value ,
          pages:       resources.total_pages ,
          count:       resources.total_count
        }
      }
    end
  end
end