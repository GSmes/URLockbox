class Api::V1::LinksController < Api::ApiController
  def index
    if current_user
      render json: current_user.links
    else
      render json: { errors: "You must be logged in." }, status: 422
    end
  end

  def create
    link = Link.create(link_params)
    current_user.links << link

    render json: link, location: nil
  end

  # def update
  #   link = Link.find(params[:id])
  #
  #   render json: link.update(link_params), location: nil
  # end

  private

  def link_params
    params.permit(:id, :title, :url, :read)
  end
end
