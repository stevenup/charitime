datatable_json_response(json) do
  json.array! @rows do |row|
    json.donation_id             row.donation_id
    json.donation_name           row.donation_name
    json.donation_category_id    DonationCategory.find_by(:id => row.donation_category_id).try(:name)
    json.donation_description    row.donation_description
    json.logistics_company       row.logistics_company
    json.delivery_num            row.delivery_num
    json.created_at              row.created_at.strftime("%Y-%m-%d %T")
    json.actions                 edit_and_del edit_admin_donation_path(row), admin_donation_path(row, :format => :json), { edit: { data: { id: row.id }, class: 'btn btn-sm btn-info edit-btn' }, delete: { data: { id: row.id, confirm: '确认删除？' }, class: 'btn btn-sm btn-dark delete-btn m-l-sm' } }
  end
end
