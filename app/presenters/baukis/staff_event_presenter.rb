module Baukis
  class StaffEventPresenter < ModelPresenter
    delegate :member, :description, :occurred_at, to: :object
    delegate :baukis_admin_staff_member_staff_events_path, to: :view_context

    def table_row
      markup(:tr) do |m|
        unless view_context.instance_variable_get(:@staff_member)
          m.td do
            m << link_to(member.family_name + member.given_name, baukis_admin_staff_member_staff_events_path(member))
          end
        end
        m.td description
        m.td(:class => 'date') do
          m.text occurred_at.strftime('%Y/%m/%d %H:%M:%S')
        end
      end
    end
  end
end