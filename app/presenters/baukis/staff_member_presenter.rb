module Baukis
  class StaffMemberPresenter < Baukis::ModelPresenter
    def suspended_mark
      object.suspended? ? view_context.raw('&#x2611;') : view_context.raw('&#x2610;')
    end
  end
end