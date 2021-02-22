class Api::V1::SearchesController < ApplicationController
  api :GET, '/v1/searches'
  def index
    searches = Search.all.order(updated_at: :desc)
    results = SearchSerializer.new(searches).serializable_hash

    render json: results, status: 200
  end

  api :GET, '/v1/searches/:id'
  param :id, :number, required: true, desc: 'id of the requested search object'
  def show
    search = Search.find(params[:id])
    result = SearchSerializer.new(search).serializable_hash

    render json: result, status: 200
  end

  api :DELETE, '/v1/searches/:id'
  param :id, :number, required: true, desc: 'id of the search object to be deleted'
  def destroy
    search = Search.find(params[:id])
    search.destroy

    render json: "Search has been deleted", status: 200
  end
end
