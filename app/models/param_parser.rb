class ParamParser
  attr_reader :parsed_url

  def initialize(url_param)
    @parsed_url = url_param.split(' ')
  end

  def path
    parsed_url[0]
  end

  def email
    parsed_url[2]
  end

  def mailable?
    parsed_url[1] == '\cc:'
  end
end
