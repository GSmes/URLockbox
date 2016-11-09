class Api::V1::LinksController < Api::ApiController
  def index
    if current_user
      render json: current_user.links
    else
      render json: { errors: "You must be logged in." }, status: 422
    end
  end

  def create
    url_params = ParamParser.new(link_params['url'])
    link = current_user.links.new(title: link_params['title'], url: url_params.path)

    if link.save && url_params.mailable?
      send_link_email(current_user, url_params)
      render json: link, status: 201, location: nil
    elsif link.save
      render json: link, status: 201, location: nil
    else
      render json: link.errors.full_messages, status: 422, location: nil
    end
  end

  def update
    link = Link.find(params[:id])
    updated_link = Link.update(params[:id], link_params)

    if updated_link.valid?
      render json: updated_link, location: nil
    else
      render json: { errors: updated_link.errors.full_messages, link: link }, status: 422, location: nil
    end
  end

  private

  def link_params
    params.permit(:id, :title, :url, :read)
  end

  def send_link_email(user, params)
    LinkMailer.send_new_link_email(user, params.email, params.path).deliver
  end
end
