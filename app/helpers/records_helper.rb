module RecordsHelper

  # `link_to_sortable` is a thin wrapper for turning column headers into links
  # that allow users to sort
  #
  # `text` - link text
  # `index` - thinking sphinx index
  # `parameters` - params hash from a request
  def link_to_sortable(text, index, parameters)
    p = parameters.clone
    p[:order]     = index
    p[:sort_mode] = p[:sort_mode].blank? || p[:sort_mode] == 'desc' ? 'asc' : 'desc'
    link_to text, records_path(p)
  end
end
