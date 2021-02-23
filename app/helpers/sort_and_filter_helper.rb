module SortAndFilterHelper
  def sorted_by(params)
    case params[:order]
    when 'asc'
      'updated_at asc'
    when 'alpha-asc'
      'query asc'
    when 'alpha-desc'
      'query desc'
    else
      'updated_at desc'
    end
  end

  def filter_by(params)
    params[:filter] || nil
  end
end