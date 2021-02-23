class CocktailService
  def initialize(query)
    @query = query
  end

  def response
    conn.get
  end

  def url
    "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{@query}"
  end

  private

  def conn
    Faraday.new(url: url)
  end
end